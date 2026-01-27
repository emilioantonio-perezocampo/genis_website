import 'package:flutter/material.dart';
import 'package:genis_website/src/shared/components/app_button.dart';
import 'package:genis_website/src/shared/components/app_card.dart';
import 'package:genis_website/src/shared/components/app_text_field.dart';
import 'package:genis_website/src/theme/app_theme.dart';
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
                      color: AppTheme.slate500,
                    ),
              ),
              const SizedBox(height: 32),
              AppButton(
                onPressed: () => setState(() => _submitted = false),
                label: 'Send another message',
                variant: AppButtonVariant.outline,
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
                                  color: AppTheme.slate500,
                                  fontSize: 18,
                                ),
                          ),
                          const SizedBox(height: 48),
                          const _ContactInfoItem(title: "Office", lines: ["123 Innovation Dr.", "San Francisco, CA 94103"]),
                          const SizedBox(height: 24),
                          const _ContactInfoItem(title: "Email", lines: ["hello@gis.ai"]),
                          const SizedBox(height: 32),
                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: const BoxDecoration(
                              color: AppTheme.slate100, // secondary
                              border: Border(left: BorderSide(color: AppTheme.blue600, width: 4)),
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(4),
                                bottomRight: Radius.circular(4),
                              ),
                            ),
                            child: const Text(
                              '"We don\'t just write code. We ship outcomes."',
                              style: TextStyle(fontStyle: FontStyle.italic, color: AppTheme.slate700),
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
                              color: AppTheme.slate500,
                            ),
                          ),
                          const SizedBox(height: 24),
                          Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(child: AppTextField(placeholder: "Jane", validator: (v) => v!.isEmpty ? 'Required' : null)),
                                    const SizedBox(width: 16),
                                    Expanded(child: AppTextField(placeholder: "Doe", validator: (v) => v!.isEmpty ? 'Required' : null)),
                                  ],
                                ),
                                const SizedBox(height: 16),
                                AppTextField(placeholder: "jane@company.com", validator: (v) => v!.isEmpty ? 'Required' : null),
                                const SizedBox(height: 16),
                                const _DropdownInput(
                                  options: [
                                    "< \"25k (Advisory/Audit)",
                                    "\"25k - \"50k (MVP Sprint)",
                                    "\"50k - \"100k (Full Project)",
                                    "\"100k+ (Enterprise/Retainer)",
                                  ],
                                ),
                                const SizedBox(height: 16),
                                AppTextField(
                                  placeholder: "E.g., We want to automate our customer support...",
                                  maxLines: 4,
                                  validator: (v) => v!.isEmpty ? 'Required' : null,
                                ),
                                const SizedBox(height: 24),
                                SizedBox(
                                  width: double.infinity,
                                  child: AppButton(
                                    onPressed: _isSubmitting ? null : _handleSubmit,
                                    label: "Submit Request",
                                    isLoading: _isSubmitting,
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
            color: AppTheme.slate600,
          ),
        )),
      ],
    );
  }
}

class _DropdownInput extends StatelessWidget {
  final List<String> options;

  const _DropdownInput({required this.options});

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        hintText: "Select a range...",
        hintStyle: const TextStyle(color: AppTheme.slate500, fontSize: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: const BorderSide(color: AppTheme.slate200),
        ),
         enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: const BorderSide(color: AppTheme.slate200),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      ),
      items: options.map((o) => DropdownMenuItem(value: o, child: Text(o, style: const TextStyle(fontSize: 14)))).toList(),
      onChanged: (val) {},
    );
  }
}