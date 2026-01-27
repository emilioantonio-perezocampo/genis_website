import 'package:flutter/material.dart';
import 'package:genis_website/src/shared/components/app_card.dart';
import 'package:lucide_icons/lucide_icons.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({super.key});

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  bool _submitted = false;
  bool _isSubmitting = false;

  final _formKey = GlobalKey<FormState>();

  Future<void> _handleSubmit() async {
    if (!_formKey.currentState!.validate()) return;
    
    setState(() => _isSubmitting = true);
    await Future.delayed(const Duration(milliseconds: 1500));
    if (mounted) {
      setState(() {
        _isSubmitting = false;
        _submitted = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_submitted) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 80),
        constraints: const BoxConstraints(minHeight: 400),
        alignment: Alignment.center,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 400),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  color: Colors.green[100],
                  shape: BoxShape.circle,
                ),
                child: Icon(LucideIcons.check, size: 32, color: Colors.green[600]),
              ),
              const SizedBox(height: 24),
              Text(
                "Message Received",
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 16),
              Text(
                "Thanks for reaching out. A member of our team (Emilio or Giovanna) will get back to you within 1-2 business days.",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
                    ),
              ),
              const SizedBox(height: 32),
              OutlinedButton(
                onPressed: () => setState(() => _submitted = false),
                child: const Text('Send another message'),
              ),
            ],
          ),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 64, horizontal: 24),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final isDesktop = constraints.maxWidth > 900;
              return Flex(
                direction: isDesktop ? Axis.horizontal : Axis.vertical,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Left Side (Info)
                  Expanded(
                    flex: isDesktop ? 1 : 0,
                    child: Padding(
                      padding: EdgeInsets.only(
                        right: isDesktop ? 48 : 0, 
                        bottom: isDesktop ? 0 : 48
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Let's build something intelligent.",
                            style: Theme.of(context).textTheme.displaySmall?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: -1.0,
                                ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            "Whether you need a full strategic roadmap or just extra hands on a complex RAG pipeline, we're ready to help.",
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                  color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
                                  fontSize: 18,
                                ),
                          ),
                          const SizedBox(height: 48),
                          _ContactInfoItem(title: "Office", lines: const ["123 Innovation Dr.", "San Francisco, CA 94103"]),
                          const SizedBox(height: 24),
                          _ContactInfoItem(title: "Email", lines: const ["hello@gis.ai"]),
                          const SizedBox(height: 32),
                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.secondary,
                              border: const Border(left: BorderSide(color: Colors.blue, width: 4)),
                              borderRadius: const BorderRadius.only(
                                topRight: Radius.circular(4),
                                bottomRight: Radius.circular(4),
                              ),
                            ),
                            child: const Text(
                              '"We don\'t just write code. We ship outcomes."',
                              style: TextStyle(fontStyle: FontStyle.italic),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Right Side (Form)
                  Expanded(
                    flex: isDesktop ? 1 : 0,
                    child: AppCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Project Intake",
                            style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "Tell us a bit about what you're looking to achieve.",
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
                            ),
                          ),
                          const SizedBox(height: 24),
                          Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(child: _TextInput(label: "First name", placeholder: "Jane")),
                                    const SizedBox(width: 16),
                                    Expanded(child: _TextInput(label: "Last name", placeholder: "Doe")),
                                  ],
                                ),
                                const SizedBox(height: 16),
                                const _TextInput(label: "Work Email", placeholder: "jane@company.com"),
                                const SizedBox(height: 16),
                                const _DropdownInput(
                                  label: "Estimated Budget",
                                  options: [
                                    "< \$25k (Advisory/Audit)",
                                    "\$25k - \$50k (MVP Sprint)",
                                    "\$50k - \$100k (Full Project)",
                                    "\$100k+ (Enterprise/Retainer)",
                                  ],
                                ),
                                const SizedBox(height: 16),
                                const _TextInput(
                                  label: "What is your primary goal?",
                                  placeholder: "E.g., We want to automate our customer support...",
                                  maxLines: 4,
                                ),
                                const SizedBox(height: 24),
                                SizedBox(
                                  width: double.infinity,
                                  height: 48,
                                  child: FilledButton(
                                    onPressed: _isSubmitting ? null : _handleSubmit,
                                    child: _isSubmitting
                                        ? const SizedBox(
                                            height: 20,
                                            width: 20,
                                            child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                                          )
                                        : const Text("Submit Request"),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class _ContactInfoItem extends StatelessWidget {
  final String title;
  final List<String> lines;

  const _ContactInfoItem({required this.title, required this.lines});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        const SizedBox(height: 8),
        ...lines.map((line) => Text(
          line,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
          ),
        )),
      ],
    );
  }
}

class _TextInput extends StatelessWidget {
  final String label;
  final String placeholder;
  final int maxLines;

  const _TextInput({required this.label, required this.placeholder, this.maxLines = 1});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14)),
        const SizedBox(height: 8),
        TextFormField(
          maxLines: maxLines,
          decoration: InputDecoration(
            hintText: placeholder,
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          ),
          validator: (value) => value == null || value.isEmpty ? 'Required' : null,
        ),
      ],
    );
  }
}

class _DropdownInput extends StatelessWidget {
  final String label;
  final List<String> options;

  const _DropdownInput({required this.label, required this.options});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14)),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
             enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          ),
          items: options.map((o) => DropdownMenuItem(value: o, child: Text(o))).toList(),
          onChanged: (val) {},
        ),
      ],
    );
  }
}
