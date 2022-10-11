part of widgets;

class FFTextEdit extends StatefulWidget {
  final String _field;
  final String _label;
  final DocumentSnapshot<Map<String, dynamic>> _doc;
  final int? maxLines;
  final int? minLines;
  final FocusNode? focusNode;
  final bool? autofocus;

  const FFTextEdit(this._doc, this._field, this._label,
      {key, this.maxLines, this.minLines, this.focusNode, this.autofocus})
      : super(key: key);

  @override
  FFTextEditState createState() => FFTextEditState();
}

class FFTextEditState extends State<FFTextEdit> {
  final _controller = TextEditingController();
  Timer? descSaveTimer;

  @override
  void initState() {
    super.initState();

    _controller.text = (widget._doc.data() != null &&
            widget._doc.data()![widget._field] != null)
        ? widget._doc.get(widget._field)
        : '';
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        autofocus: widget.autofocus ?? false,
        focusNode: widget.focusNode,
        maxLines: widget.maxLines,
        minLines: widget.minLines,
        controller: _controller,
        //textAlignVertical: TextAlignVertical.bottom,
        // cursorColor: Theme.of(context).cursorColor,
        decoration: InputDecoration(
          labelText: widget._label,
          // hintText: widget._label,
          // labelStyle: TextStyle(
          //   color: Colors.black, // Color(0xFF6200EE),
          // ),
        ),
        onChanged: (String txt) {
          if (descSaveTimer != null && descSaveTimer!.isActive) {
            descSaveTimer!.cancel();
          }
          descSaveTimer = Timer(const Duration(seconds: 1), () {
            if (widget._doc.data() == null ||
                txt != widget._doc.data()![widget._field]) {
              Map<String, dynamic> map = <String, dynamic>{};
              map[widget._field] = txt;
              widget._doc.reference.set(map, SetOptions(merge: true));
            }
          });
        });
  }
}

class FFLTTextEdit extends StatefulWidget {
  final String _field;
  final String _label;
  final String _tooltip;
  final DocumentSnapshot<Map<String, dynamic>> _doc;
  final IconData? icon;
  final int maxLines;

  const FFLTTextEdit(this._doc, this._field, this._label, this._tooltip,
      {key: Key, this.maxLines = 1, this.icon})
      : super(key: key);

  @override
  _FFLTTextEditState createState() => _FFLTTextEditState();
}

class _FFLTTextEditState extends State<FFLTTextEdit> {
  final _controller = TextEditingController();
  bool isEditing = false;

  @override
  void initState() {
    super.initState();
    _controller.text = (widget._doc.data() != null &&
            widget._doc.data()![widget._field] != null)
        ? widget._doc.get(widget._field)
        : '';
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: widget.icon == null ? null : Icon(widget.icon),
      title: Text(widget._label),
      subtitle: isEditing
          ? FFTextEdit(widget._doc, widget._field, widget._label,
              maxLines: widget.maxLines)
          : Text(_controller.text),
      trailing: IconButton(
        icon: const Icon(Icons.edit),
        tooltip: widget._tooltip,
        onPressed: () {
          setState(() {
            isEditing = !isEditing;
          });
        },
      ),
    );
  }
}

class RFTextEdit extends StatefulWidget {
  final String _field;
  final String _label;
  final DocumentReference<Map<String, dynamic>> _doc;
  final int? maxLines;
  final int? minLines;

  const RFTextEdit(this._doc, this._field, this._label,
      {this.maxLines, this.minLines, key})
      : super(key: key);

  @override
  RFTextEditState createState() => RFTextEditState();
}

class RFTextEditState extends State<RFTextEdit> {
  final _controller = TextEditingController();
  Timer? descSaveTimer;
  Stream<DocumentSnapshot<Map<String, dynamic>>>? sub;

  @override
  void initState() {
    super.initState();

    sub = widget._doc.snapshots();
    sub!
        .distinct(
            (a, b) => a.data()![widget._field] != b.data()![widget._field])
        .listen((event) {
      if (event.data()![widget._field] != _controller.text) {
        _controller.text = event.data()![widget._field];
      }
    });
    // _controller.text = (widget._doc.data() != null &&
    //         widget._doc.data()![widget._field] != null)
    //     ? widget._doc.get(widget._field)
    //     : '';
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        maxLines: widget.maxLines,
        minLines: widget.minLines,
        controller: _controller,
        // cursorColor: Theme.of(context).cursorColor,
        decoration: InputDecoration(
          labelText: widget._label,
          // labelStyle: TextStyle(
          //   color: Colors.black, // Color(0xFF6200EE),
          // ),
        ),
        onChanged: (String txt) {
          if (descSaveTimer != null && descSaveTimer!.isActive) {
            descSaveTimer!.cancel();
          }
          descSaveTimer = Timer(const Duration(seconds: 1), () {
            Map<String, dynamic> map = <String, dynamic>{};
            map[widget._field] = txt;
            widget._doc.set(map, SetOptions(merge: true));
          });
        });
  }
}

class RFTextEdit1 extends StatefulWidget {
  final String _field;
  final String _label;
  final DocumentReference<Map<String, dynamic>> _doc;
  final int? maxLines;
  final int? minLines;
  final FocusNode? _focusNode;
  final TextEditingController _controller; // = TextEditingController();
  final bool isControllerProvided;

  RFTextEdit1(
    this._doc,
    this._field,
    this._label,
    controller,
    focusNode, {
    this.maxLines,
    this.minLines,
    key,
  })  : _controller = controller ?? TextEditingController(),
        _focusNode =
            focusNode, // != null ? focusNode : TextEditingController(),
        isControllerProvided = controller != null ? true : false,
        super(key: key);

  @override
  RFTextEditState1 createState() => RFTextEditState1();
}

class RFTextEditState1 extends State<RFTextEdit1> {
  Timer? descSaveTimer;
  Stream<DocumentSnapshot<Map<String, dynamic>>>? sub;

  @override
  void initState() {
    super.initState();

    sub = widget._doc.snapshots();
    sub!
        .distinct(
            (a, b) => a.data()![widget._field] != b.data()![widget._field])
        .listen((event) {
      if (event.data()![widget._field] != widget._controller.text) {
        widget._controller.text = event.data()![widget._field];
      }
    });
    // _controller.text = (widget._doc.data() != null &&
    //         widget._doc.data()![widget._field] != null)
    //     ? widget._doc.get(widget._field)
    //     : '';
  }

  @override
  void dispose() {
    if (!widget.isControllerProvided) widget._controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        focusNode: widget._focusNode,
        maxLines: widget.maxLines,
        minLines: widget.minLines,
        controller: widget._controller,
        // cursorColor: Theme.of(context).cursorColor,
        decoration: InputDecoration(
          labelText: widget._label,
          // labelStyle: TextStyle(
          //   color: Colors.black, // Color(0xFF6200EE),
          // ),
        ),
        onChanged: (String txt) {
          if (descSaveTimer != null && descSaveTimer!.isActive) {
            descSaveTimer!.cancel();
          }
          descSaveTimer = Timer(const Duration(seconds: 1), () {
            Map<String, dynamic> map = <String, dynamic>{};
            map[widget._field] = txt;
            widget._doc.set(map, SetOptions(merge: true));
          });
        });
  }
}
