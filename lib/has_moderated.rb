require 'has_moderated/moderation_model'
require 'has_moderated/carrier_wave'
require 'has_moderated/common'
require 'has_moderated/user_hooks'
require 'has_moderated/moderated_create'
require 'has_moderated/moderated_destroy'
require 'has_moderated/moderated_attributes'
require 'has_moderated/moderated_associations'

module HasModerated
  def self.included(base)
    #base.send :extend, HasModerated::Common
    HasModerated::Common::included(base)
    base.send :extend, HasModerated::UserHooks::ClassMethods
    base.send :extend, HasModerated::ModeratedCreate::ClassMethods
    base.send :extend, HasModerated::ModeratedDestroy::ClassMethods
    base.send :extend, HasModerated::ModeratedAssociations::ClassMethods
    base.send :extend, HasModerated::ModeratedAttributes::ClassMethods
  end
end

ActiveRecord::Base.send :include, HasModerated
