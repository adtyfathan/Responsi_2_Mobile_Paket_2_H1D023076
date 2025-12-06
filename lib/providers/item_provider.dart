import 'package:flutter/material.dart';
import '../models/item_model.dart';
import '../services/api_service.dart';

class ItemProvider with ChangeNotifier {
  final ApiService _apiService = ApiService();

  List<Item> _items = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<Item> get items => _items;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> fetchItems() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _items = await _apiService.getItems();
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> addItem(Item item) async {
    final result = await _apiService.createItem(item);

    if (result['success']) {
      await fetchItems(); // Refresh list
      return true;
    } else {
      _errorMessage = result['message'];
      notifyListeners();
      return false;
    }
  }

  Future<bool> updateItem(int id, Item item) async {
    final result = await _apiService.updateItem(id, item);

    if (result['success']) {
      await fetchItems(); // Refresh list
      return true;
    } else {
      _errorMessage = result['message'];
      notifyListeners();
      return false;
    }
  }

  Future<bool> deleteItem(int id) async {
    final result = await _apiService.deleteItem(id);

    if (result['success']) {
      await fetchItems(); // Refresh list
      return true;
    } else {
      _errorMessage = result['message'];
      notifyListeners();
      return false;
    }
  }
}