# frozen_string_literal: true

# == Schema Information
#
# Table name: people
#
#  id              :bigint           not null, primary key
#  birth_date      :date
#  contact_type_cd :integer          default(0), not null
#  description     :text
#  discarded_at    :datetime
#  document_1      :string
#  document_2      :string
#  email           :string
#  first_name      :string           not null
#  last_name       :string
#  person_type_cd  :integer          default(0), not null
#  phone_number    :string
#  type            :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  account_id      :bigint
#
# Indexes
#
#  index_people_on_account_id                            (account_id)
#  index_people_on_account_id_and_type_and_discarded_at  (account_id,type,discarded_at)
#  index_people_on_contact_type_cd                       (contact_type_cd)
#  index_people_on_discarded_at                          (discarded_at)
#  index_people_on_person_type_cd                        (person_type_cd)
#  index_people_on_type                                  (type)
#
# Foreign Keys
#
#  fk_rails_...  (account_id => accounts.id)
#
class Contact < Person
  include Contacts::Searchable
  include Auditable

  CONTACT_TYPES = {
    undefined_contact: 0,
    customer: 1,
    employee: 2,
    supplier: 3
  }.freeze

  acts_as_tenant :account
  as_enum :contact_type, CONTACT_TYPES

  belongs_to :account
  has_many :transactions, dependent: :restrict_with_error

  def destroy_or_discard
    return discard if transactions.exists?

    destroy
  end
end
