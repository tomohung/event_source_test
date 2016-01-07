class GuestbooksController < ApplicationController
  before_action :set_guestbook, only: [:show, :edit, :update, :destroy]

  # GET /guestbooks
  # GET /guestbooks.json
  def index
    @guestbooks = Guestbook.all
  end

  # GET /guestbooks/1
  # GET /guestbooks/1.json
  def show
    client = RailsEventStore::Client.new
    stream_name = "Guestbook"
    client.read_all_events(stream_name)
  end

  # GET /guestbooks/new
  def new
    @guestbook = Guestbook.new
  end

  # GET /guestbooks/1/edit
  def edit
  end

  # POST /guestbooks
  # POST /guestbooks.json
  def create
    client = RailsEventStore::Client.new
    event_data = {data: guestbook_params }
    event = ProductAdded.new(event_data)
    #publishing event for specific stream
    stream_name = 'Guestbook'
    client.publish_event(event, stream_name)

    @guestbook = Guestbook.new(guestbook_params)

    respond_to do |format|
      if @guestbook.save
        format.html { redirect_to @guestbook, notice: 'Guestbook was successfully created.' }
        format.json { render :show, status: :created, location: @guestbook }
      else
        format.html { render :new }
        format.json { render json: @guestbook.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /guestbooks/1
  # PATCH/PUT /guestbooks/1.json
  def update
    respond_to do |format|
      if @guestbook.update(guestbook_params)
        format.html { redirect_to @guestbook, notice: 'Guestbook was successfully updated.' }
        format.json { render :show, status: :ok, location: @guestbook }
      else
        format.html { render :edit }
        format.json { render json: @guestbook.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /guestbooks/1
  # DELETE /guestbooks/1.json
  def destroy
    @guestbook.destroy
    respond_to do |format|
      format.html { redirect_to guestbooks_url, notice: 'Guestbook was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_guestbook
      @guestbook = Guestbook.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def guestbook_params
      params.require(:guestbook).permit(:name, :content)
    end
end
