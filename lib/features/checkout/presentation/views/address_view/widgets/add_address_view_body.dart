import 'package:coffee_app/core/utils/app_router.dart';
import 'package:coffee_app/core/utils/color_palette.dart';
import 'package:coffee_app/core/utils/text_styles.dart';
import 'package:coffee_app/core/widgets/custom_app_bar.dart';
import 'package:coffee_app/core/widgets/custom_elevated_button.dart';
import 'package:coffee_app/core/widgets/custom_icon_button.dart';
import 'package:coffee_app/core/widgets/custom_rounded_images.dart';
import 'package:coffee_app/core/widgets/prettier_tap.dart';
import 'package:coffee_app/core/widgets/title_subtitle.dart';
import 'package:coffee_app/features/checkout/data/models/address_model.dart';
import 'package:coffee_app/features/checkout/presentation/manager/address/address_cubit.dart';
import 'package:coffee_app/generated/l10n.dart';
import 'package:coffee_app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ionicons/ionicons.dart';

class AddAddressViewBody extends StatefulWidget {
  const AddAddressViewBody({super.key});

  @override
  State<AddAddressViewBody> createState() => _AddAddressViewBodyState();
}

class _AddAddressViewBodyState extends State<AddAddressViewBody> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _stateController;
  late TextEditingController _cityController;
  late TextEditingController _addressController;
  late TextEditingController _titleController;
  late TextEditingController _phoneController;
  late TextEditingController _optionalPhoneController;
  double? lat;
  double? lng;

  @override
  void initState() {
    super.initState();
    _stateController = TextEditingController();
    _cityController = TextEditingController();
    _addressController = TextEditingController();
    _titleController = TextEditingController();
    _phoneController = TextEditingController();
    _optionalPhoneController = TextEditingController();
  }

  @override
  void dispose() {
    _stateController.dispose();
    _cityController.dispose();
    _addressController.dispose();
    _titleController.dispose();
    _phoneController.dispose();
    _optionalPhoneController.dispose();
    super.dispose();
  }

  String? _requiredValidator(String? value, String field) {
    if (value == null || value.trim().isEmpty) {
      return "$field ${S.current.isRequired}";
    }
    return null;
  }

  String? _phoneValidator(String? value, {bool required = true}) {
    if (value == null || value.trim().isEmpty) {
      if (required) return S.current.phoneNumberRequired;
      return null;
    }
    final regex = RegExp(r'^[0-9]{7,15}$');
    if (!regex.hasMatch(value.trim())) {
      return S.current.enterValidPhone;
    }
    return null;
  }

  void _submitForm() async {
    if (_formKey.currentState?.validate() ?? false) {
      context.read<AddressCubit>().addAddress(
        address: _addressController.text.trim(),
        city: _cityController.text.trim(),
        latitude: lat,
        longitude: lng,
        phoneNumber: _phoneController.text.trim(),
        state: _stateController.text.trim(),
        title: _titleController.text.trim(),
        optionalPhoneNumber: _optionalPhoneController.text.trim(),
      );
      GoRouter.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: 16,
        children: [
          CustomAppBar(
            leading: CustomIconButton(
              padding: 8,
              onPressed: () => GoRouter.of(context).pop(),
              child: Icon(
                Ionicons.chevron_back,
                color: context.colors.onSecondary,
              ),
            ),
          ),
          TitleSubtitle(
            title: S.current.addLocationTitle,
            subtitle: S.current.addLocationSubtitle,
          ),

          PrettierTap(
            shrink: 1,
            onPressed: () async {
              final AddressModel? result = await GoRouter.of(context)
                  .push<AddressModel>(
                    AppRouter.kMapView,
                    extra: lat != null ? {'lat': lat!, 'lng': lng!} : null,
                  );
              if (result != null) {
                setState(() {
                  _stateController.text = result.state;
                  _cityController.text = result.city;
                  _addressController.text = result.address;
                  lat = result.latitude;
                  lng = result.longitude;
                });
              }
            },
            child: Stack(
              children: [
                CustomRoundedImage(
                  imageUrl: staticMapUrl(
                    lat: lat ?? 30.0444,
                    lng: lng ?? 31.2357,
                  ),
                  aspectRatio: 16 / 9,
                  width: context.width,
                ),
                Positioned.directional(
                  textDirection: context.isArabic
                      ? TextDirection.rtl
                      : TextDirection.ltr,
                  bottom: 1,
                  child: Container(
                    margin: const EdgeInsets.all(8),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: ColorPalette.eerieBlack.withValues(alpha: 0.8),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Ionicons.map_outline,
                          color: context.colors.onPrimary,
                          size: 18,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          S.current.openMap,
                          style: TextStyles.regular15.copyWith(
                            color: context.colors.onPrimary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          Row(
            spacing: 16,
            children: [
              Expanded(
                child: TextFormField(
                  controller: _stateController,
                  decoration: InputDecoration(
                    hintText: S.current.state,
                    prefixIcon: const Icon(Ionicons.map_outline),
                  ),
                  autovalidateMode: AutovalidateMode.onUnfocus,
                  validator: (v) => _requiredValidator(v, S.current.state),
                ),
              ),
              Expanded(
                child: TextFormField(
                  controller: _cityController,
                  decoration: InputDecoration(
                    hintText: S.current.city,
                    prefixIcon: const Icon(Ionicons.business_outline),
                  ),
                  autovalidateMode: AutovalidateMode.onUnfocus,
                  validator: (v) => _requiredValidator(v, S.current.city),
                ),
              ),
            ],
          ),

          TextFormField(
            controller: _addressController,
            decoration: InputDecoration(
              hintText: S.current.address,
              prefixIcon: const Icon(Ionicons.location_outline),
            ),
            keyboardType: TextInputType.multiline,
            maxLines: null,
            autovalidateMode: AutovalidateMode.onUnfocus,
            validator: (v) => _requiredValidator(v, S.current.address),
          ),

          TextFormField(
            controller: _titleController,
            decoration: InputDecoration(
              hintText: S.current.title,
              prefixIcon: const Icon(Ionicons.home_outline),
            ),
            autovalidateMode: AutovalidateMode.onUnfocus,
            validator: (v) => _requiredValidator(v, S.current.title),
          ),

          TextFormField(
            controller: _phoneController,
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
              hintText: S.current.phoneNumber,
              prefixIcon: const Icon(Ionicons.call_outline),
            ),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (v) => _phoneValidator(v, required: true),
          ),

          TextFormField(
            controller: _optionalPhoneController,
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
              hintText: S.current.optionalPhoneNumber,
              prefixIcon: const Icon(Ionicons.call_outline),
            ),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (v) => _phoneValidator(v, required: false),
          ),

          const SizedBox(height: 20),
          CustomElevatedButton(
            onPressed: _submitForm,
            child: Text(S.current.saveAddress, style: TextStyles.medium20),
          ),
        ],
      ),
    );
  }
}

String staticMapUrl({
  required double lat,
  required double lng,
  int zoom = 64,
  int width = 600,
  int height = 300,
}) {
  final scale = 0.1 / (zoom * 0.5);

  final minLon = lng - scale;
  final minLat = lat - scale;
  final maxLon = lng + scale;
  final maxLat = lat + scale;

  return "https://server.arcgisonline.com/ArcGIS/rest/services/World_Imagery/MapServer/export"
      "?bbox=$minLon,$minLat,$maxLon,$maxLat"
      "&bboxSR=4326"
      "&size=$width,$height"
      "&imageSR=4326"
      "&format=png"
      "&f=image";
}
