import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'dart:async';

class SearchBarWidget extends StatefulWidget {
  final void Function(String) onChanged;
  final String? hintText;

  const SearchBarWidget({super.key, required this.onChanged, this.hintText});

  @override
  State<SearchBarWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  final TextEditingController _controller = TextEditingController();
  final _searchSubject = BehaviorSubject<String>();
  StreamSubscription? _searchSubscription;

  @override
  void initState() {
    super.initState();

    // Debounce de 500ms - espera a que el usuario deje de escribir
    _searchSubscription = _searchSubject
        .debounceTime(const Duration(milliseconds: 500))
        .distinct() // Evita búsquedas duplicadas consecutivas
        .listen((query) {
          widget.onChanged(query);
        });
  }

  @override
  void dispose() {
    _searchSubscription?.cancel();
    _searchSubject.close();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.2),
        ),
      ),
      child: TextField(
        controller: _controller,
        onChanged: (value) {
          setState(() {}); // Para actualizar el botón de limpiar
          _searchSubject.add(value); // Agregar al stream con debounce
        },
        decoration: InputDecoration(
          hintText: widget.hintText ?? 'Buscar por ciudad, título...',
          hintStyle: TextStyle(
            color: Theme.of(
              context,
            ).colorScheme.onSurface.withValues(alpha: 0.6),
          ),
          prefixIcon: Icon(
            Icons.search,
            color: Theme.of(
              context,
            ).colorScheme.onSurface.withValues(alpha: 0.6),
          ),
          suffixIcon: _controller.text.isNotEmpty
              ? IconButton(
                  icon: Icon(
                    Icons.clear,
                    color: Theme.of(
                      context,
                    ).colorScheme.onSurface.withValues(alpha: 0.6),
                  ),
                  onPressed: () {
                    _controller.clear();
                    setState(() {});
                    _searchSubject.add(''); // Limpiar búsqueda con debounce
                  },
                )
              : null,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),
        ),
      ),
    );
  }
}
