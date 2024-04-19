class CommentPolicy < ApplicationPolicy
  def create?
    user&.id
  end

  def destroy?
    user&.id == record.user.id || user&.admin?
  end
end
