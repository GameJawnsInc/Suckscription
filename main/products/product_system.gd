class_name ProductSystem extends Node2D


var inventory: Array[ProductsGlob.Product]
var stock: Array[int]

func on_items_selected(product_list: Array[ProductsGlob.Product]) -> void:
	inventory.clear()
	for product in product_list:
		inventory.push_back(product)
		stock.push_back(1)


func get_inventory_slot(index: int) -> ProductsGlob.Product:
	return inventory[index]

func is_product_in_inventory(product_id: ProductsGlob.Product) -> bool:
	for product in inventory:
		if product == product_id:
			return true
	return false

func is_product_in_stock(product_id: ProductsGlob.Product) -> bool:
	if !is_product_in_inventory(product_id):
		return false
	if stock[inventory.find(product_id)] == 0:
		return false
	return true
