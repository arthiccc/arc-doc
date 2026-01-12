class DocumentPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    user.admin? || (record.category.department == user.department)
  end

  def create?
    user.admin? || (user.staff? && user.department_id.present? && record.category.department_id == user.department_id)
  end

  def update?
    create?
  end

  def destroy?
    user.admin? || (user.staff? && user.department_id.present? && record.category.department_id == user.department_id)
  end

  class Scope < Scope
    def resolve
      if user.admin?
        scope.all
      elsif user.department_id.present?
        scope.joins(category: :department).where(categories: { department_id: user.department_id })
      else
        scope.none
      end
    end
  end
end
