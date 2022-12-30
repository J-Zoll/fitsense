enum BloodGroup {
  aPlus("A+"),
  bPlus("B+"),
  abPlus("AB+"),
  zeroPlus("0+"),
  aMinus("A-"),
  bMinus("B-"),
  abMinus("AB-"),
  zeroMinus("0-");

  final String name;
  const BloodGroup(this.name);

  static BloodGroup? fromName(String name) {
    switch(name) {
      case "A+": return BloodGroup.aPlus;
      case "B+": return BloodGroup.bPlus;
      case "AB+": return BloodGroup.abPlus;
      case "0+": return BloodGroup.zeroPlus;
      case "A-": return BloodGroup.aMinus;
      case "B-": return BloodGroup.bMinus;
      case "AB-": return BloodGroup.abMinus;
      case "0-": return BloodGroup.zeroMinus;
      default: return null;
    }
  }
}