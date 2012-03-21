module HasModerated
  module Associations
    module HasMany
      def self.add_assoc_to_record(to, record, reflection)
        fk = HasModerated::Common::foreign_key(reflection).try(:to_s)
        field = if !reflection.options[:as].blank?
          # todo: extract
          reflection.options[:as].to_s
        elsif !fk.blank?
          results = record.class.reflections.reject do |assoc_name, assoc|
            !(HasModerated::Common::foreign_key(assoc).try(:to_s) == fk)
          end
          if results.blank?
            raise "Please set foreign_key for both belongs_to and has_one/has_many!"
          end
          results.first[1].name.to_s
        else
          to.class.to_s.underscore
        end
        HasModerated::Common::try_disable_moderation(record) do
          record.send(field + "=", to)
        end
      end
      
      module ClassMethods
        protected
          def has_moderated_has_many_association(reflection)
            # lazy load
            self.send :extend, HasModerated::Associations::Collection::ClassMethods
            has_moderated_collection_association(reflection)
          end
      end
    end
  end
end