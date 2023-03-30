class QuestionPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end

  def index?
  true
  end

  def new?
    true
  end

  def create?
    new?
  end

  def show?
    true
  end

  def edit?
    @user.has_role? :admin
  end

  def update?
    edit?
  end

  def destroy?
    @user.has_role? :admin
  end
end
