how it is working
The contract is deployed by Address A, becoming the owner.
Address A sets the price of the vehicle to 10 Ether using the setPrice function.
Address A lists a vehicle for sale with the make "Toyota" and model "Camry" using the listVehicleForSale function.
Address B wants to purchase the vehicle and calls the buyVehicle function, sending 10 Ether.
The function checks that the Ether sent is sufficient and that Address B has not previously purchased a vehicle.
The function updates ownership, transfers the payment to Address A, and emits a purchase event.
If Address B calls checkOwnership, it will return true because Address B now owns the vehicle.