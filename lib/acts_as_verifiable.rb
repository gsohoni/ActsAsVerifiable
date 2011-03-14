module ActsAsVerifiable

  class VerificationStatus < ActiveRecord::Base
    belongs_to :verifiable, :polymorphic => true
  end

  def self.included(mod)
    mod.extend(ClassMethods)
  end

  module ClassMethods
    def acts_as_verifiable(options = {})
      before_update :check_entity_state
      after_save :set_verification

      has_one :verification_status, :as => :verifiable
    end
  end

  def set_as_verified
    vs = self.verification_status
    vs.is_verified = true
    vs.save!
  end

  # tells if the entity is verified
  def is_verified?
    self.verification_status.is_verified
  end

  private

  def check_entity_state    
    if self.changed?
      self.verification_status.is_verified = false
    end
    return true
  end

  # create / update verification status
  def set_verification
    unless self.verification_status
      vs = VerificationStatus.new(:is_verified => false)
      vs.verifiable = self
    else
      vs = self.verification_status
      vs.is_verified = false
    end
    vs.save!
  end
end

