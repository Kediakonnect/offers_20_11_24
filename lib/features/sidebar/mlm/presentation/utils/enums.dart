enum InviteAndEarnBtns {
  bonusSystem,
  presentBonus,
  bonusWithdrawal,
  productsToRefer,
  offers,
  seminarsInMyArea,
}

extension InviteAndEarnBtnsExtension on InviteAndEarnBtns {
  String get label {
    switch (this) {
      case InviteAndEarnBtns.bonusSystem:
        return "Bonus System";
      case InviteAndEarnBtns.presentBonus:
        return "Present Bonus";
      case InviteAndEarnBtns.bonusWithdrawal:
        return "Bonus Withdrawal";
      case InviteAndEarnBtns.productsToRefer:
        return "Products to Refer";
      case InviteAndEarnBtns.offers:
        return "Offers";
      case InviteAndEarnBtns.seminarsInMyArea:
        return "Seminars in My Area";
      default:
        return "";
    }
  }
}
