module ActsAsVerifiable

  class VerificationStatus < ActiveRecord::Base
    belongs_to :verifiable, :polymorphic => true
  end

  def self.included(mod)
    mod.extend(ClassMethods)
  end

  module ClassMethods
    def acts_as_verifiable(options = {})
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

  # create / update verification status
  def set_verification
    unless self.verification_status
      vs = VerificationStatus.new(:is_verified => false)
      vs.verifiable = self
    else
      vs = self.verification_status
      vs.is_verified = false if self.changed?
    end
    vs.save!
  end
end

