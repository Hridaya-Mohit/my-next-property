import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import '../theme/mnp_theme.dart';
import '../mnp_app.dart';
import '../mnp_analytics.dart';
import '../widgets/mnp_page_scaffold.dart';

const _whatsAppUrl = 'https://wa.me/919818812223?text=Hi%2C%20I%27d%20like%20to%20schedule%20a%20consultation%20regarding%20a%20property.';

const _emailJsServiceId  = 'service_2peaeac';
const _emailJsTemplateId = 'template_ez8bw7d';
const _emailJsPublicKey  = 'QGRb3w0XuoNKazAQZ';

class MNPContactPage extends StatefulWidget {
  const MNPContactPage({super.key});

  @override
  State<MNPContactPage> createState() => _MNPContactPageState();
}

class _MNPContactPageState extends State<MNPContactPage> {
  @override
  Widget build(BuildContext context) {
    return MNPPageScaffold(
      activePage: MNPRoutes.contact,
      body: Column(
        children: [
          _ContactHero(),
          _ContactBody(),
        ],
      ),
    );
  }
}

class _ContactHero extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final hPad = MNPDimensions.horizontalPadding(context);
    return SizedBox(
      height: 480,
      width: double.infinity,
      child: Stack(
        fit: StackFit.expand,
        children: [
          CachedNetworkImage(
            imageUrl:
                'https://images.unsplash.com/photo-1497366216548-37526070297c?w=1600&q=80',
            fit: BoxFit.cover,
          ),
          Container(color: Colors.black.withOpacity(0.7)),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: hPad),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'REACH OUT',
                  style: GoogleFonts.lato(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    color: MNPColors.gold,
                    letterSpacing: 3,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Contact Us',
                  style: MNPTextStyles.displaySmall(context)
                      .copyWith(color: MNPColors.white),
                ),
                const SizedBox(height: 16),
                Container(width: 60, height: 2, color: MNPColors.gold),
                const SizedBox(height: 24),
                Text(
                  'Private Consultation — Absolute Discretion Guaranteed',
                  style: GoogleFonts.cormorantGaramond(
                    fontSize: 16,
                    fontStyle: FontStyle.italic,
                    color: MNPColors.white.withOpacity(0.7),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ContactBody extends StatefulWidget {
  @override
  State<_ContactBody> createState() => _ContactBodyState();
}

class _ContactBodyState extends State<_ContactBody> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  final _messageCtrl = TextEditingController();
  String _requirement = 'Luxury Residential Advisory';
  bool _submitted = false;
  bool _loading = false;
  String? _error;

  @override
  void dispose() {
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _phoneCtrl.dispose();
    _messageCtrl.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() { _loading = true; _error = null; });

    try {
      final response = await http.post(
        Uri.parse('https://api.emailjs.com/api/v1.0/email/send'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'service_id':  _emailJsServiceId,
          'template_id': _emailJsTemplateId,
          'user_id':     _emailJsPublicKey,
          'template_params': {
            'from_name':   _nameCtrl.text.trim(),
            'from_email':  _emailCtrl.text.trim(),
            'phone':       _phoneCtrl.text.trim(),
            'requirement': _requirement,
            'message':     _messageCtrl.text.trim(),
          },
        }),
      );

      if (response.statusCode == 200) {
        trackEvent('form_submit', label: 'contact_enquiry');
        setState(() => _submitted = true);
      } else {
        setState(() => _error = 'Something went wrong. Please try again.');
      }
    } catch (_) {
      setState(() => _error = 'Network error. Please check your connection.');
    } finally {
      setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final hPad = MNPDimensions.horizontalPadding(context);
    final isDesktop = MNPDimensions.isDesktop(context);

    return Container(
      color: MNPColors.ivory,
      padding: EdgeInsets.symmetric(horizontal: hPad, vertical: 80),
      child: isDesktop
          ? Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                    flex: 5,
                    child: _submitted ? _successMessage() : _buildForm()),
                const SizedBox(width: 80),
                Expanded(flex: 3, child: _ContactInfo()),
              ],
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _submitted ? _successMessage() : _buildForm(),
                const SizedBox(height: 60),
                _ContactInfo(),
              ],
            ),
    );
  }

  Widget _successMessage() {
    return Container(
      padding: const EdgeInsets.all(40),
      decoration: BoxDecoration(
        border: Border.all(color: MNPColors.gold),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.check_circle_outline,
              color: MNPColors.gold, size: 40),
          const SizedBox(height: 20),
          Text(
            'Thank you for your enquiry.',
            style: GoogleFonts.cormorantGaramond(
              fontSize: 28,
              fontWeight: FontWeight.w400,
              color: MNPColors.charcoal,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Your enquiry will be handled with absolute discretion. We typically respond within one business day.',
            style: GoogleFonts.lato(
              fontSize: 14,
              fontWeight: FontWeight.w300,
              color: MNPColors.warmGrey,
              height: 1.7,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildForm() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'ENQUIRY FORM',
            style: GoogleFonts.lato(
              fontSize: 10,
              fontWeight: FontWeight.w700,
              color: MNPColors.gold,
              letterSpacing: 3,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Begin a Private Conversation',
            style: MNPTextStyles.displaySmall(context),
          ),
          const SizedBox(height: 8),
          Text(
            'All enquiries are handled with the utmost confidentiality.',
            style: GoogleFonts.lato(
              fontSize: 13,
              fontWeight: FontWeight.w300,
              color: MNPColors.warmGrey,
            ),
          ),
          const SizedBox(height: 40),
          _UETextField(
            label: 'Full Name',
            controller: _nameCtrl,
            validator: (v) => (v == null || v.isEmpty) ? 'Required' : null,
          ),
          const SizedBox(height: 24),
          _UETextField(
            label: 'Email Address',
            controller: _emailCtrl,
            keyboardType: TextInputType.emailAddress,
            validator: (v) =>
                (v == null || !v.contains('@')) ? 'Enter valid email' : null,
          ),
          const SizedBox(height: 24),
          _UETextField(
            label: 'Phone Number',
            controller: _phoneCtrl,
            keyboardType: TextInputType.phone,
          ),
          const SizedBox(height: 24),
          _UEDropdown(
            label: 'Requirement',
            value: _requirement,
            items: const [
              'Luxury Residential Advisory',
              'Commercial Leasing & Sales',
              'Industrial Asset Consulting',
              'Investment & Portfolio Strategy',
              'NRI Investment Advisory',
              'Other',
            ],
            onChanged: (v) => setState(() => _requirement = v!),
          ),
          const SizedBox(height: 24),
          _UETextField(
            label: 'Message',
            controller: _messageCtrl,
            maxLines: 5,
          ),
          const SizedBox(height: 36),
          GestureDetector(
            onTap: _loading ? null : _submit,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 18),
              color: _loading ? MNPColors.warmGrey : MNPColors.charcoal,
              child: _loading
                  ? const Center(
                      child: SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: MNPColors.white,
                        ),
                      ),
                    )
                  : Text(
                      'SUBMIT ENQUIRY',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.lato(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: MNPColors.white,
                        letterSpacing: 3,
                      ),
                    ),
            ),
          ),
          if (_error != null) ...[
            const SizedBox(height: 12),
            Text(
              _error!,
              style: GoogleFonts.lato(
                fontSize: 12,
                color: Colors.redAccent,
                fontWeight: FontWeight.w300,
              ),
            ),
          ],
          const SizedBox(height: 12),
          Text(
            'By submitting, you agree to our Privacy Policy. We will not share your information.',
            style: GoogleFonts.lato(
              fontSize: 11,
              color: MNPColors.warmGrey,
              fontWeight: FontWeight.w300,
            ),
          ),
        ],
      ),
    );
  }
}

class _ContactInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'CONTACT DETAILS',
          style: GoogleFonts.lato(
            fontSize: 10,
            fontWeight: FontWeight.w700,
            color: MNPColors.gold,
            letterSpacing: 3,
          ),
        ),
        const SizedBox(height: 32),
        _contactBlock(
          Icons.location_on_outlined,
          'Our Office',
          'Shop No. 37, Opposite Vita Dairy\nSector 46, Gurgaon-122003\nHaryana',
        ),
        const SizedBox(height: 32),
        _contactBlock(
          Icons.phone_outlined,
          'Phone & WhatsApp',
          '+91 98188 12223',
        ),
        const SizedBox(height: 32),
        _contactBlock(
          Icons.email_outlined,
          'Email',
          'info@mynextproperty.in\nluxury@mynextproperty.in',
        ),
        const SizedBox(height: 48),
        Container(height: 1, color: MNPColors.lightGrey),
        const SizedBox(height: 32),
        Text(
          'BUSINESS HOURS',
          style: GoogleFonts.lato(
            fontSize: 10,
            fontWeight: FontWeight.w700,
            color: MNPColors.gold,
            letterSpacing: 3,
          ),
        ),
        const SizedBox(height: 16),
        _hoursRow('Monday – Saturday', '9:00 AM – 7:00 PM'),
        _hoursRow('Sunday', 'By Appointment'),
        const SizedBox(height: 48),
        // WhatsApp CTA
        GestureDetector(
          onTap: () {
            trackEvent('cta_click', label: 'whatsapp_contact_page');
            launchUrl(Uri.parse(_whatsAppUrl));
          },
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 16),
            color: const Color(0xFF25D366),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.chat_outlined, color: Colors.white, size: 18),
                const SizedBox(width: 10),
                Text(
                  'MESSAGE ON WHATSAPP',
                  style: GoogleFonts.lato(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    letterSpacing: 2,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 40),
        // Map placeholder
        Container(
          height: 220,
          width: double.infinity,
          color: MNPColors.beige,
          child: Stack(
            children: [
              const Center(
                child: Icon(Icons.location_on_outlined,
                    size: 48, color: MNPColors.warmGrey),
              ),
              Positioned(
                bottom: 16,
                left: 16,
                right: 16,
                child: Container(
                  padding: const EdgeInsets.all(12),
                  color: MNPColors.charcoal,
                  child: Text(
                    'Shop No. 37, Opposite Vita Dairy\nSector 46, Gurgaon-122003\nHaryana',
                    style: GoogleFonts.lato(
                      fontSize: 12,
                      color: MNPColors.warmGrey,
                      height: 1.5,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _contactBlock(IconData icon, String title, String detail) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: MNPColors.gold, size: 20),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: GoogleFonts.cormorantGaramond(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: MNPColors.charcoal,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                detail,
                style: GoogleFonts.lato(
                  fontSize: 13,
                  fontWeight: FontWeight.w300,
                  color: MNPColors.warmGrey,
                  height: 1.6,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _hoursRow(String day, String hours) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            day,
            style: GoogleFonts.lato(
              fontSize: 13,
              fontWeight: FontWeight.w300,
              color: MNPColors.warmGrey,
            ),
          ),
          Text(
            hours,
            style: GoogleFonts.lato(
              fontSize: 13,
              fontWeight: FontWeight.w400,
              color: MNPColors.charcoal,
            ),
          ),
        ],
      ),
    );
  }
}

class _UETextField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final int maxLines;

  const _UETextField({
    required this.label,
    required this.controller,
    this.validator,
    this.keyboardType,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label.toUpperCase(),
          style: GoogleFonts.lato(
            fontSize: 10,
            fontWeight: FontWeight.w700,
            color: MNPColors.charcoal,
            letterSpacing: 2,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          validator: validator,
          keyboardType: keyboardType,
          maxLines: maxLines,
          style: GoogleFonts.lato(
            fontSize: 14,
            fontWeight: FontWeight.w300,
            color: MNPColors.charcoal,
          ),
          decoration: InputDecoration(
            filled: true,
            fillColor: MNPColors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.zero,
              borderSide: const BorderSide(color: MNPColors.lightGrey),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.zero,
              borderSide: const BorderSide(color: MNPColors.lightGrey),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.zero,
              borderSide: const BorderSide(color: MNPColors.gold, width: 1.5),
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          ),
        ),
      ],
    );
  }
}

class _UEDropdown extends StatelessWidget {
  final String label;
  final String value;
  final List<String> items;
  final void Function(String?) onChanged;

  const _UEDropdown({
    required this.label,
    required this.value,
    required this.items,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label.toUpperCase(),
          style: GoogleFonts.lato(
            fontSize: 10,
            fontWeight: FontWeight.w700,
            color: MNPColors.charcoal,
            letterSpacing: 2,
          ),
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          initialValue: value,
          onChanged: onChanged,
          style: GoogleFonts.lato(
            fontSize: 14,
            fontWeight: FontWeight.w300,
            color: MNPColors.charcoal,
          ),
          decoration: const InputDecoration(
            filled: true,
            fillColor: MNPColors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.zero,
              borderSide: BorderSide(color: MNPColors.lightGrey),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.zero,
              borderSide: BorderSide(color: MNPColors.lightGrey),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.zero,
              borderSide: BorderSide(color: MNPColors.gold, width: 1.5),
            ),
            contentPadding:
                EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          ),
          items: items
              .map((i) => DropdownMenuItem(value: i, child: Text(i)))
              .toList(),
        ),
      ],
    );
  }
}
