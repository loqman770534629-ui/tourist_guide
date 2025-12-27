import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({super.key});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  DateTime? _checkInDate;
  DateTime? _checkOutDate;
  int _adults = 1;
  int _children = 0;
  String _tripPurpose = 'ترفيه';

  @override
  void dispose() {
    _nameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context, bool isCheckIn) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: (isCheckIn ? _checkInDate : _checkOutDate) ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
    );
    if (picked != null) {
      setState(() {
        if (isCheckIn) {
          _checkInDate = picked;
          if (_checkOutDate != null && _checkOutDate!.isBefore(_checkInDate!)) {
            _checkOutDate = null;
          }
        } else {
          _checkOutDate = picked;
        }
      });
    }
  }

  // دالة رسالة النجاح
  void _showSuccessDialog(BuildContext context) {
    final primaryColor = Theme.of(context).colorScheme.primary;
    final textColor = Theme.of(context).textTheme.bodyLarge?.color ?? Colors.black;
    
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          backgroundColor: Theme.of(context).dialogBackgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          title: Row(
            children: [
              Icon(Icons.check_circle, color: primaryColor, size: 28),
              const SizedBox(width: 10),
              Text(
                'تم الإرسال',
                style: TextStyle(color: textColor),
              ),
            ],
          ),
          content: Text(
            'تم استلام طلب الحجز وسوف يتم الرد عليه قريباً.',
            style: TextStyle(color: textColor.withOpacity(0.7), fontSize: 16),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext); // إغلاق رسالة التأكيد
                // تنظيف الحقول
                _nameController.clear();
                _lastNameController.clear();
                _emailController.clear();
                _phoneController.clear();
                setState(() {
                  _checkInDate = null;
                  _checkOutDate = null;
                  _adults = 1;
                  _children = 0;
                  _tripPurpose = 'ترفيه';
                });
              },
              child: Text(
                'حسناً',
                style: TextStyle(
                  color: primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  // دالة الفاتورة
  void _showConfirmationSheet(BuildContext context) {
    const roomPrice = 150.00;
    const nights = 3;
    const total = roomPrice * nights;

    final primaryColor = Theme.of(context).colorScheme.primary;
    final backgroundColor = Theme.of(context).cardColor;
    final textColor = Theme.of(context).textTheme.bodyLarge?.color ?? Colors.black;
    final dividerColor = Theme.of(context).dividerColor;

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (BuildContext sheetContext) {
        return Container(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.85,
          ),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 60,
                    height: 5,
                    decoration: BoxDecoration(
                      color: dividerColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'مراجعة الحجز',
                    style: TextStyle(
                      color: textColor,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  // عرض البيانات
                  _buildSectionTitle('البيانات الشخصية'),
                  _buildDetailRow('الاسم الأول:', _nameController.text),
                  _buildDetailRow('الاسم العائلة:', _lastNameController.text),
                  _buildDetailRow('البريد الإلكتروني:', _emailController.text),
                  _buildDetailRow('رقم الجوال:', _phoneController.text),
                  Divider(color: dividerColor, height: 30),
                  _buildSectionTitle('تفاصيل الإقامة'),
                  _buildDetailRow(
                    'تاريخ الوصول:',
                    _checkInDate?.toLocal().toString().split(' ')[0] ??
                        'لم يحدد',
                  ),
                  _buildDetailRow(
                    'تاريخ المغادرة:',
                    _checkOutDate?.toLocal().toString().split(' ')[0] ??
                        'لم يحدد',
                  ),
                  _buildDetailRow('البالغين:', _adults.toString()),
                  _buildDetailRow('الأطفال:', _children.toString()),
                  _buildDetailRow('الغرض:', _tripPurpose),
                  Divider(color: dividerColor, height: 30),
                  _buildSectionTitle('ملخص السعر'),
                  _buildDetailRow('نوع الغرفة:', 'جناح ديلوكس'),
                  _buildDetailRow(
                    'السعر / ليلة:',
                    '\$${roomPrice.toStringAsFixed(2)}',
                  ),
                  _buildDetailRow('عدد الليالي:', '$nights ليالي'),
                  _buildDetailRow(
                    'الإجمالي المستحق:',
                    '\$${total.toStringAsFixed(2)}',
                    isTotal: true,
                  ),
                  const SizedBox(height: 30),
                  // أزرار التأكيد والإلغاء
                  _buildShadowButton(
                    text: 'تأكيد الحجز النهائي',
                    color: primaryColor,
                    onPressed: () {
                      Navigator.pop(sheetContext);
                      _showSuccessDialog(context);
                    },
                  ),
                  const SizedBox(height: 10),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(sheetContext);
                    },
                    child: Text(
                      'الغاء',
                      style: TextStyle(
                        color: textColor.withOpacity(0.7),
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).colorScheme.primary;
    
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          'تأكيد الحجز',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).appBarTheme.foregroundColor,
          ),
        ),
        iconTheme: IconThemeData(
          color: Theme.of(context).appBarTheme.foregroundColor,
        ),
        backgroundColor: primaryColor,
        elevation: 5,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- قسم البيانات الشخصية ---
            _buildSectionTitle('البيانات الشخصية'),
            _buildLightTextField(
              hint: 'الاسم الأول',
              icon: Icons.person_outline,
              controller: _nameController,
            ),
            const SizedBox(height: 16),
            _buildLightTextField(
              hint: 'الاسم العائلة',
              icon: Icons.person_outline,
              controller: _lastNameController,
            ),
            const SizedBox(height: 16),
            _buildLightTextField(
              hint: 'البريد الإلكتروني',
              icon: Icons.email_outlined,
              keyboardType: TextInputType.emailAddress,
              controller: _emailController,
            ),
            const SizedBox(height: 16),
            _buildLightTextField(
              hint: 'رقم الجوال',
              icon: Icons.phone_outlined,
              keyboardType: TextInputType.phone,
              controller: _phoneController,
            ),
            const SizedBox(height: 30),

            // --- قسم تفاصيل الإقامة ---
            _buildSectionTitle('تفاصيل الإقامة'),
            Row(
              children: [
                Expanded(
                  child: _buildDatePickerField(
                    label: 'تاريخ الوصول',
                    date: _checkInDate,
                    onTap: () => _selectDate(context, true),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildDatePickerField(
                    label: 'تاريخ المغادرة',
                    date: _checkOutDate,
                    onTap: () => _selectDate(context, false),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            _buildGuestCounter(
              'البالغين',
              _adults,
              (val) => setState(() => _adults = val),
            ),
            const SizedBox(height: 16),
            _buildGuestCounter(
              'الأطفال',
              _children,
              (val) => setState(() => _children = val),
            ),
            const SizedBox(height: 30),

            // --- قسم الغرض من الرحلة (من تصميمك الأصلي) ---
            _buildSectionTitle('الغرض من الرحلة'),
            _buildTripPurposeSelector(),
            const SizedBox(height: 30),

            // --- قسم ملخص السعر ---
            _buildSectionTitle('ملخص السعر'),
            _buildPriceSummary(),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20.0),
        child: _buildShadowButton(
          text: 'متابعة للمراجعة',
          color: primaryColor,
          onPressed: () {
            _showConfirmationSheet(context);
          },
        ),
      ),
    );
  }

  // --- ويدجتس مساعدة ---

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Text(
        title,
        style: TextStyle(
          color: Theme.of(context).textTheme.titleLarge?.color,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  // حقل الإدخال
  Widget _buildLightTextField({
    required String hint,
    required IconData icon,
    required TextEditingController controller,
    TextInputType? keyboardType,
  }) {
    final primaryColor = Theme.of(context).colorScheme.primary;
    final textColor = Theme.of(context).textTheme.bodyLarge?.color ?? Colors.black;
    final hintColor = textColor.withOpacity(0.6);
    final borderColor = Theme.of(context).dividerColor;
    final fillColor = Theme.of(context).cardColor;
    
    return TextField(
      controller: controller,
      style: TextStyle(color: textColor),
      textAlign: TextAlign.right,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        filled: true,
        fillColor: fillColor,
        hintText: hint,
        hintStyle: TextStyle(color: hintColor),
        prefixIcon: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Icon(
            icon,
            color: hintColor,
          ),
        ),
        // إطار أنيق
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none, // إخفاء الإطار الافتراضي
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(
            color: primaryColor, // يتغير للأزرق عند التركيز
            width: 2.0,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(
            color: borderColor, // إطار خفيف
            width: 1.0,
          ),
        ),
      ),
    );
  }

  // منتقي التاريخ
  Widget _buildDatePickerField({
    required String label,
    DateTime? date,
    required VoidCallback onTap,
  }) {
    String text = date != null
        ? date.toLocal().toString().split(' ')[0]
        : label;
    bool hasDate = date != null;

    final primaryColor = Theme.of(context).colorScheme.primary;
    final textColor = Theme.of(context).textTheme.bodyLarge?.color ?? Colors.black;
    final hintColor = textColor.withOpacity(0.6);
    final borderColor = Theme.of(context).dividerColor;
    final fillColor = Theme.of(context).cardColor;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
        decoration: BoxDecoration(
          color: fillColor,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: hasDate ? primaryColor : borderColor,
            width: hasDate ? 2.0 : 1.0,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(
              Icons.calendar_month_outlined,
              color: hasDate ? primaryColor : hintColor,
            ),
            Text(
              text,
              style: TextStyle(
                color: hasDate ? textColor : hintColor,
                fontSize: 16,
                fontWeight: hasDate ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // عداد النزلاء
  Widget _buildGuestCounter(
    String label,
    int count,
    ValueChanged<int> onChanged,
  ) {
    final primaryColor = Theme.of(context).colorScheme.primary;
    final textColor = Theme.of(context).textTheme.bodyLarge?.color ?? Colors.black;
    final borderColor = Theme.of(context).dividerColor;
    final fillColor = Theme.of(context).cardColor;
    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: fillColor,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: borderColor),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(color: textColor, fontSize: 16),
          ),
          Row(
            children: [
              IconButton(
                icon: const Icon(
                  Icons.remove_circle_outline,
                  color: Colors.red,
                ),
                onPressed: count > (label == 'البالغين' ? 1 : 0)
                    ? () => onChanged(count - 1)
                    : null,
              ),
              Text(
                count.toString(),
                style: TextStyle(
                  color: textColor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                icon: Icon(Icons.add_circle_outline, color: primaryColor),
                onPressed: () => onChanged(count + 1),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // اختيار الغرض
  Widget _buildTripPurposeSelector() {
    final primaryColor = Theme.of(context).colorScheme.primary;
    final textColor = Theme.of(context).textTheme.bodyLarge?.color ?? Colors.black;
    final borderColor = Theme.of(context).dividerColor;
    final fillColor = Theme.of(context).cardColor;
    
    return Container(
      decoration: BoxDecoration(
        color: fillColor,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: borderColor),
      ),
      child: Column(
        children: [
          RadioListTile<String>(
            title: Text(
              'ترفيه',
              style: TextStyle(color: textColor),
            ),
            value: 'ترفيه',
            groupValue: _tripPurpose,
            onChanged: (value) => setState(() => _tripPurpose = value!),
            activeColor: primaryColor,
            secondary: Icon(
              FontAwesomeIcons.umbrellaBeach,
              color: primaryColor,
            ),
          ),
          Divider(color: borderColor, height: 1),
          RadioListTile<String>(
            title: Text(
              'عمل',
              style: TextStyle(color: textColor),
            ),
            value: 'عمل',
            groupValue: _tripPurpose,
            onChanged: (value) => setState(() => _tripPurpose = value!),
            activeColor: primaryColor,
            secondary: Icon(
              FontAwesomeIcons.briefcase,
              color: primaryColor,
            ),
          ),
        ],
      ),
    );
  }

  // ملخص السعر
  Widget _buildPriceSummary() {
    const roomPrice = 150.00;
    const nights = 3;
    const total = roomPrice * nights;

    final borderColor = Theme.of(context).dividerColor;
    final fillColor = Theme.of(context).cardColor;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: fillColor,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: borderColor),
      ),
      child: Column(
        children: [
          _buildDetailRow('نوع الغرفة:', 'جناح ديلوكس'),
          _buildDetailRow('السعر / ليلة:', '\$${roomPrice.toStringAsFixed(2)}'),
          _buildDetailRow('عدد الليالي:', '$nights ليالي'),
          Divider(color: borderColor, height: 20),
          _buildDetailRow(
            'الإجمالي المستحق:',
            '\$${total.toStringAsFixed(2)}',
            isTotal: true,
          ),
        ],
      ),
    );
  }

  // صف التفاصيل (للفاتورة والملخص)
  Widget _buildDetailRow(String title, String value, {bool isTotal = false}) {
    final primaryColor = Theme.of(context).colorScheme.primary;
    final textColor = Theme.of(context).textTheme.bodyLarge?.color ?? Colors.black;
    final hintColor = textColor.withOpacity(0.7);
    
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(color: hintColor, fontSize: 16),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              value.isEmpty ? 'لم يدخل' : value,
              textAlign: TextAlign.end,
              style: TextStyle(
                color: isTotal ? primaryColor : textColor,
                fontSize: isTotal ? 20 : 16,
                fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // الزر
  Widget _buildShadowButton({
    required String text,
    required Color color,
    required VoidCallback onPressed,
    IconData? icon,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(30),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (icon != null) ...[
                  FaIcon(icon, size: 20, color: Colors.white),
                  const SizedBox(width: 12),
                ],
                Text(
                  text,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
