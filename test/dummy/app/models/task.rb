class Task < ActiveRecord::Base
  attr_accessible :title
  has_many :subtasks
  has_many :task_photos
  has_and_belongs_to_many :hjoin_tests
  has_and_belongs_to_many :habtms, :class_name => "HabtmNameTest"
  has_one :hone_test
  has_one :hone_as_test, :as => :testable
  has_many :hmanythrough_join
  has_many :hmanythrough_test, :through => :hmanythrough_join
  has_many :lalas, :class_name => "HmanyFkTest", :foreign_key => "something_id"
  has_moderated :title, :desc
  has_moderated_create :with_associations => [:subtasks, :task_photos, :hjoin_tests, :hone_test, :hmanythrough_test, :hmanythrough_join, :hone_as_test, :lalas]
  has_moderated_association :all
  has_moderated_destroy
end
