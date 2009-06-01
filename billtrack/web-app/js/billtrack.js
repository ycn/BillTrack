function checkOut(obj,name) {
	if (obj.checked) obj.setAttribute('name',name);
	else obj.removeAttribute('name');
}