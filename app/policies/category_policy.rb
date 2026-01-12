class CategoryPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    user.admin? || (record.department == user.department)
  end

  def create?
    user.admin? || (user.staff? && user.department_id.present? && record.department_id == user.department_id)
  end

  def update?
    create?
  end

  def destroy?
    user.admin? || (user.staff? && user.department_id.present? && record.department_id == user.department_id)
  end

  class Scope < Scope
    def resolve
      if user.admin?
        scope.all
      elsif user.department_id.present?
        scope.where(department_id: user.department_id)
      else
        scope.none
      end
    end
  end
end
