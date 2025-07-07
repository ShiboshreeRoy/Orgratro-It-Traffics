# app/controllers/instructions_controller.rb
class InstructionsController < ApplicationController
  

  def index
    @users = User.all
    @instructions = Instruction.all
     session[:instruction_ids] ||= Instruction.pluck(:id).shuffle
  if session[:instruction_ids].empty?
    session[:instruction_ids] = Instruction.pluck(:id).shuffle
  end
  current_id = session[:instruction_ids].pop
  @instructions = [Instruction.find(current_id)]
  
  if current_admin.present?
    @instructions = Instruction.all
   
  elsif current_user.present?
    @instructions = current_user.instructions
  else
    redirect_to new_user_session_path, alert: "You must log in first."
  end
end


  def new
    @instruction = Instruction.new
  end

  def create
    @instruction = Instruction.new(instruction_params)
    if @instruction.save
      redirect_to instructions_path, notice: "Instruction sent successfully"
    else
      render :new
    end
  end

  def track_click
    instruction = Instruction.find(params[:id])
    InstructionClick.create!(
      instruction: instruction,
      user: current_user,
      clicked_at: Time.current
    )
    redirect_to instruction.link,allow_other_host: true
  end

  private

  def instruction_params
    params.require(:instruction).permit(:title, :body, :link, :user_id)
  end
end
