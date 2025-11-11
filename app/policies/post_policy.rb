class PostPolicy < ApplicationPolicy
  # all methods inherit initialize(user, record) from ApplicationPolicy
  def index?
    true
  end

  def show?
    true
  end

  def create?
    user.present?
  end

  def update?
    user.admin? || user == record.user
  end

  def destroy?
    user.admin? || user == record.user
  end

  class Scope < Scope
    def resolve
      if user.admin?
        scope.all
      else
        scope.where(user: user)
      end
    end
  end
end
