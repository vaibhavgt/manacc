module TransactionsHelper

	def categories_arr(obj_arr)
		obj_arr.each.map{|c| [c.source, c.id]}
	end
end
