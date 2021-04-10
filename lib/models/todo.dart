class Todo {
  String _id = '';
  String _name = '';
  String _description = '';
  bool _completed = false;

  // Default constructor
  Todo(this._id, this._name, this._completed);

  // Obligatory getter/setters
  String get id => this._id;
  set id(String id) => this._id = id;

  String get name => this._name;
  set name(String name) => this._name = name;

  String get description => this._description;
  set description(String description) => this._description = description;

  bool get isCompleted => this._completed;
  set completed(bool state) => this._completed = state;
}