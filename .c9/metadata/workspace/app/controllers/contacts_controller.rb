{"filter":false,"title":"contacts_controller.rb","tooltip":"/app/controllers/contacts_controller.rb","undoManager":{"mark":61,"position":61,"stack":[[{"group":"doc","deltas":[{"start":{"row":8,"column":0},"end":{"row":13,"column":0},"action":"remove","lines":["","  # GET /contacts/1","  # GET /contacts/1.json","  def show","  end",""]}]}],[{"group":"doc","deltas":[{"start":{"row":3,"column":1},"end":{"row":8,"column":0},"action":"remove","lines":[" # GET /contacts","  # GET /contacts.json","  def index","    @contacts = Contact.all","  end",""]}]}],[{"group":"doc","deltas":[{"start":{"row":9,"column":2},"end":{"row":12,"column":0},"action":"remove","lines":["# GET /contacts/1/edit","  def edit","  end",""]}]}],[{"group":"doc","deltas":[{"start":{"row":3,"column":1},"end":{"row":59,"column":7},"action":"remove","lines":["","  # GET /contacts/new","  def new","    @contact = Contact.new","  end","","  ","  # POST /contacts","  # POST /contacts.json","  def create","    @contact = Contact.new(contact_params)","","    respond_to do |format|","      if @contact.save","        format.html { redirect_to @contact, notice: 'Contact was successfully created.' }","        format.json { render action: 'show', status: :created, location: @contact }","      else","        format.html { render action: 'new' }","        format.json { render json: @contact.errors, status: :unprocessable_entity }","      end","    end","  end","","  # PATCH/PUT /contacts/1","  # PATCH/PUT /contacts/1.json","  def update","    respond_to do |format|","      if @contact.update(contact_params)","        format.html { redirect_to @contact, notice: 'Contact was successfully updated.' }","        format.json { head :no_content }","      else","        format.html { render action: 'edit' }","        format.json { render json: @contact.errors, status: :unprocessable_entity }","      end","    end","  end","","  # DELETE /contacts/1","  # DELETE /contacts/1.json","  def destroy","    @contact.destroy","    respond_to do |format|","      format.html { redirect_to contacts_url }","      format.json { head :no_content }","    end","  end","","  private","    # Use callbacks to share common setup or constraints between actions.","    def set_contact","      @contact = Contact.find(params[:id])","    end","","    # Never trust parameters from the scary internet, only allow the white list through.","    def contact_params","      params.require(:contact).permit(:name, :email, :subject, :message)","    end"]},{"start":{"row":3,"column":1},"end":{"row":16,"column":5},"action":"insert","lines":["def new","    @contact = Contact.new","  end","","  def create","    @contact = Contact.new(params[:contact])","","    if @contact.valid?","      redirect_to :action => 'new'","      return  ","    end","","    render :action => 'new'","  end"]}]}],[{"group":"doc","deltas":[{"start":{"row":1,"column":2},"end":{"row":1,"column":69},"action":"remove","lines":["before_action :set_contact, only: [:show, :edit, :update, :destroy]"]}]}],[{"group":"doc","deltas":[{"start":{"row":1,"column":2},"end":{"row":2,"column":0},"action":"remove","lines":["",""]}]}],[{"group":"doc","deltas":[{"start":{"row":1,"column":2},"end":{"row":2,"column":0},"action":"remove","lines":["",""]}]}],[{"group":"doc","deltas":[{"start":{"row":1,"column":2},"end":{"row":1,"column":3},"action":"remove","lines":[" "]}]}],[{"group":"doc","deltas":[{"start":{"row":1,"column":2},"end":{"row":14,"column":5},"action":"remove","lines":["def new","    @contact = Contact.new","  end","","  def create","    @contact = Contact.new(params[:contact])","","    if @contact.valid?","      redirect_to :action => 'new'","      return  ","    end","","    render :action => 'new'","  end"]},{"start":{"row":1,"column":2},"end":{"row":16,"column":5},"action":"insert","lines":["def new","    @contact = Contact.new","  end","","  def create","    @contact = Contact.new(params[:contact])","","    if @contact.valid?","      ContactMailer.contact_message(params[:contact]).deliver","      flash[:notice] = 'Mensagem enviado com sucesso'","      redirect_to :action => 'new'","      return  ","    end","","    render :action => 'mew'","  end"]}]}],[{"group":"doc","deltas":[{"start":{"row":15,"column":23},"end":{"row":15,"column":24},"action":"remove","lines":["m"]}]}],[{"group":"doc","deltas":[{"start":{"row":15,"column":23},"end":{"row":15,"column":24},"action":"insert","lines":["n"]}]}],[{"group":"doc","deltas":[{"start":{"row":5,"column":12},"end":{"row":6,"column":0},"action":"insert","lines":["",""]},{"start":{"row":6,"column":0},"end":{"row":6,"column":4},"action":"insert","lines":["    "]}]}],[{"group":"doc","deltas":[{"start":{"row":6,"column":4},"end":{"row":6,"column":5},"action":"insert","lines":["@"]}]}],[{"group":"doc","deltas":[{"start":{"row":6,"column":5},"end":{"row":7,"column":0},"action":"remove","lines":["",""]}]}],[{"group":"doc","deltas":[{"start":{"row":6,"column":5},"end":{"row":6,"column":6},"action":"remove","lines":[" "]}]}],[{"group":"doc","deltas":[{"start":{"row":6,"column":4},"end":{"row":6,"column":5},"action":"remove","lines":["@"]}]}],[{"group":"doc","deltas":[{"start":{"row":6,"column":4},"end":{"row":6,"column":6},"action":"remove","lines":["  "]}]}],[{"group":"doc","deltas":[{"start":{"row":1,"column":9},"end":{"row":2,"column":0},"action":"insert","lines":["",""]},{"start":{"row":2,"column":0},"end":{"row":2,"column":4},"action":"insert","lines":["    "]}]}],[{"group":"doc","deltas":[{"start":{"row":2,"column":4},"end":{"row":2,"column":5},"action":"insert","lines":["@"]}]}],[{"group":"doc","deltas":[{"start":{"row":2,"column":5},"end":{"row":2,"column":6},"action":"insert","lines":["t"]}]}],[{"group":"doc","deltas":[{"start":{"row":2,"column":6},"end":{"row":2,"column":7},"action":"insert","lines":["i"]}]}],[{"group":"doc","deltas":[{"start":{"row":2,"column":7},"end":{"row":2,"column":8},"action":"insert","lines":["t"]}]}],[{"group":"doc","deltas":[{"start":{"row":2,"column":8},"end":{"row":2,"column":9},"action":"insert","lines":["l"]}]}],[{"group":"doc","deltas":[{"start":{"row":2,"column":9},"end":{"row":2,"column":10},"action":"insert","lines":["e"]}]}],[{"group":"doc","deltas":[{"start":{"row":2,"column":10},"end":{"row":2,"column":11},"action":"insert","lines":[" "]}]}],[{"group":"doc","deltas":[{"start":{"row":2,"column":11},"end":{"row":2,"column":12},"action":"insert","lines":["="]}]}],[{"group":"doc","deltas":[{"start":{"row":2,"column":12},"end":{"row":2,"column":13},"action":"insert","lines":[" "]}]}],[{"group":"doc","deltas":[{"start":{"row":2,"column":13},"end":{"row":2,"column":15},"action":"insert","lines":["\"\""]}]}],[{"group":"doc","deltas":[{"start":{"row":2,"column":15},"end":{"row":2,"column":16},"action":"insert","lines":[" "]}]}],[{"group":"doc","deltas":[{"start":{"row":2,"column":14},"end":{"row":2,"column":15},"action":"insert","lines":["E"]}]}],[{"group":"doc","deltas":[{"start":{"row":2,"column":15},"end":{"row":2,"column":16},"action":"insert","lines":["n"]}]}],[{"group":"doc","deltas":[{"start":{"row":2,"column":16},"end":{"row":2,"column":17},"action":"insert","lines":["t"]}]}],[{"group":"doc","deltas":[{"start":{"row":2,"column":17},"end":{"row":2,"column":18},"action":"insert","lines":["r"]}]}],[{"group":"doc","deltas":[{"start":{"row":2,"column":18},"end":{"row":2,"column":19},"action":"insert","lines":["e"]}]}],[{"group":"doc","deltas":[{"start":{"row":2,"column":19},"end":{"row":2,"column":20},"action":"insert","lines":[" "]}]}],[{"group":"doc","deltas":[{"start":{"row":2,"column":20},"end":{"row":2,"column":21},"action":"insert","lines":["e"]}]}],[{"group":"doc","deltas":[{"start":{"row":2,"column":21},"end":{"row":2,"column":22},"action":"insert","lines":["m"]}]}],[{"group":"doc","deltas":[{"start":{"row":2,"column":22},"end":{"row":2,"column":23},"action":"insert","lines":[" "]}]}],[{"group":"doc","deltas":[{"start":{"row":2,"column":23},"end":{"row":2,"column":24},"action":"insert","lines":["c"]}]}],[{"group":"doc","deltas":[{"start":{"row":2,"column":24},"end":{"row":2,"column":25},"action":"insert","lines":["o"]}]}],[{"group":"doc","deltas":[{"start":{"row":2,"column":25},"end":{"row":2,"column":26},"action":"insert","lines":["n"]}]}],[{"group":"doc","deltas":[{"start":{"row":2,"column":26},"end":{"row":2,"column":27},"action":"insert","lines":["t"]}]}],[{"group":"doc","deltas":[{"start":{"row":2,"column":27},"end":{"row":2,"column":28},"action":"insert","lines":["a"]}]}],[{"group":"doc","deltas":[{"start":{"row":2,"column":28},"end":{"row":2,"column":29},"action":"insert","lines":["t"]}]}],[{"group":"doc","deltas":[{"start":{"row":2,"column":29},"end":{"row":2,"column":30},"action":"insert","lines":["o"]}]}],[{"group":"doc","deltas":[{"start":{"row":2,"column":30},"end":{"row":2,"column":31},"action":"insert","lines":[" "]}]}],[{"group":"doc","deltas":[{"start":{"row":2,"column":31},"end":{"row":2,"column":32},"action":"insert","lines":["c"]}]}],[{"group":"doc","deltas":[{"start":{"row":2,"column":32},"end":{"row":2,"column":33},"action":"insert","lines":["n"]}]}],[{"group":"doc","deltas":[{"start":{"row":2,"column":33},"end":{"row":2,"column":34},"action":"insert","lines":["o"]}]}],[{"group":"doc","deltas":[{"start":{"row":2,"column":33},"end":{"row":2,"column":34},"action":"remove","lines":["o"]}]}],[{"group":"doc","deltas":[{"start":{"row":2,"column":32},"end":{"row":2,"column":33},"action":"remove","lines":["n"]}]}],[{"group":"doc","deltas":[{"start":{"row":2,"column":32},"end":{"row":2,"column":33},"action":"insert","lines":["o"]}]}],[{"group":"doc","deltas":[{"start":{"row":2,"column":33},"end":{"row":2,"column":34},"action":"insert","lines":["n"]}]}],[{"group":"doc","deltas":[{"start":{"row":2,"column":34},"end":{"row":2,"column":35},"action":"insert","lines":["o"]}]}],[{"group":"doc","deltas":[{"start":{"row":2,"column":35},"end":{"row":2,"column":36},"action":"insert","lines":["s"]}]}],[{"group":"doc","deltas":[{"start":{"row":2,"column":36},"end":{"row":2,"column":37},"action":"insert","lines":["t"]}]}],[{"group":"doc","deltas":[{"start":{"row":2,"column":36},"end":{"row":2,"column":37},"action":"remove","lines":["t"]}]}],[{"group":"doc","deltas":[{"start":{"row":2,"column":36},"end":{"row":2,"column":37},"action":"insert","lines":["c"]}]}],[{"group":"doc","deltas":[{"start":{"row":2,"column":37},"end":{"row":2,"column":38},"action":"insert","lines":["o"]}]}],[{"group":"doc","deltas":[{"start":{"row":2,"column":38},"end":{"row":2,"column":39},"action":"insert","lines":["!"]}]}],[{"group":"doc","deltas":[{"start":{"row":6,"column":12},"end":{"row":7,"column":0},"action":"insert","lines":["",""]},{"start":{"row":7,"column":0},"end":{"row":7,"column":4},"action":"insert","lines":["    "]}]}],[{"group":"doc","deltas":[{"start":{"row":7,"column":4},"end":{"row":7,"column":41},"action":"insert","lines":["@title = \"Entre em contato conosco!\" "]}]}]]},"ace":{"folds":[],"scrolltop":0,"scrollleft":0,"selection":{"start":{"row":3,"column":26},"end":{"row":3,"column":26},"isBackwards":false},"options":{"guessTabSize":true,"useWrapMode":false,"wrapToView":true},"firstLineState":0},"timestamp":1423576233000,"hash":"47be3e669d18163b465af1a7419da5c047250fc4"}