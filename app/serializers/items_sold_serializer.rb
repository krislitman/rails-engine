class ItemsSoldSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name
  attribute :count, &:item_count
end
