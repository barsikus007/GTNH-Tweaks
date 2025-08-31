// #region Ore Lists
// taken from https://wiki.gtnewhorizons.com/wiki/Integrated_Ore_Factory#Automation
// const oresArray = [...document.querySelectorAll("td:nth-child(1) li")].map(el => el.innerText)
const ores30s = `
Apatite Ore
Asbestos Ore
Asbestos Ore [End]
BArTiMaEuSNek Ore
Bentonite Ore
Chalcopyrite Ore
Chalcopyrite Ore [End]
Chrysotile Ore
Electrotine Ore
Fullers Earth
Iridium Ore
Iridium Ore [End]
Malachite Ore
Malachite Ore [End]
Meteoric Iron Ore
Meteoric Iron Ore [End]
Osmium Ore
Osmium Ore [End]
Palladium Ore
Palladium Ore [End]
Pentlandite Ore
Pentlandite Ore [End]
Platinum Ore
Platinum Ore [End]
Pollucite Ore
Pyrochlore Ore
Pyrolusite Ore
Quartz Sand
Red Descloizite Ore
Sheldonite Ore
Tantalite Ore
Vermiculite
Yellow Limonite Ore
`; // 30s (OW/TC/M)

// const oresArray = [...document.querySelectorAll("td:nth-child(4) li")].map(el => el.innerText)
const ores20s = `
Aer Infused Stone
Aer Infused Stone [End]
Aqua Infused Stone
Aqua Infused Stone [End]
Cassiterite Ore
Cassiterite Ore [End]
Certus Quartz Ore
Certus Quartz Ore [End]
Charged Certus Quartz Ore
Cinnabar Ore
Coal Ore (GT)
Coal Ore (GT) [End]
Diamond Ore (GT)
Diamond Ore (GT) [End]
Emerald Ore (GT)
Emerald Ore (GT) [End]
Ignis Infused Stone
Ignis Infused Stone [End]
Ilmenite Ore
Jasper Ore
Nether Quartz Ore
Nether Quartz Ore [End]
Nether Star Ore
Nether Star Ore [End]
Opal Ore
Opal Ore [End]
Ordo Infused Stone
Ordo Infused Stone [End]
Perditio Infused Stone
Perditio Infused Stone [End]
Prasiolite Ore
Sapphire Ore
Sapphire Ore [End]
Terra Infused Stone
Terra Infused Stone [End]
Tin Ore
Tin Ore [End]
Tricalcium Phosphate Ore
Tricalcium Phosphate Ore [End]
`; // 20s (M/OW/Sifting)

// const oresArray = [...document.querySelectorAll("td:nth-child(2) li")].map(el => el.innerText)
const ores15s = `
Agardite (Cd) Ore
Agardite (La) Ore
Agardite (Nd) Ore
Agardite (Y) Ore
Americium Ore
Americium Ore [End]
Arsenopyrite Ore
Barite Ore
Barium Ore
Barium Ore [End]
Bauxite Ore
Bauxite Ore [End]
Bedrockium Ore
Bedrockium Ore [End]
Black Plutonium Ore
Black Plutonium Ore [End]
Borax Ore
Borax Ore [End]
Bornite Ore
Cadmium Ore
Cadmium Ore [End]
Callisto Ice Ore
Callisto Ice Ore [End]
Chrome Ore
Chrome Ore [End]
Chromite Ore
Chromite Ore [End]
Chromo-Alumino-Povondraite Ore
Cosmic Neutronium Ore
Cosmic Neutronium Ore [End]
Crude Rhodium Metal Ore
Demicheleite (Br) Ore
Diatomite Ore
Dilithium Ore
Dolomite Ore
Enriched Naquadah Ore
Enriched-Naquadah Oxide Mixture Ore
Europium Ore
Europium Ore [End]
Ferberite Ore
Firestone Ore
Florencite Ore
Fluor-Buergerite Ore
Forcicium Ore
Forcillium Ore
Gadolinite (Ce) Ore
Gadolinite (Y) Ore
Galena Ore
Garnet Sand
Geikielite Ore
Glauconite Ore
Glauconite Sand
Gold Ore (GT)
Gold Ore (GT) [End]
Green Sapphire Ore
Green Sapphire Ore [End]
Hedenbergite Ore
Holmium Ore
Huebnerite Ore
Indium Ore
Indium Ore [End]
Infinity Catalyst Ore
Infinity Catalyst Ore [End]
Iridium Metal Residue Ore
Iron Ore (GT)
Iron Ore (GT) [End]
Kashinite Ore
Koboldite Ore
Lanthanite (Ce) Ore
Lanthanite (La) Ore
Lanthanum Ore
Lapis Ore (GT)
Lapis Ore (GT) [End]
Lazurite Ore
Lazurite Ore [End]
Leach Residue Ore
Lepidolite Ore
Lepidolite Ore [End]
Loellingite Ore
Magnesite Ore
Magnesium Ore
Magnetite Ore
Magnetite Ore [End]
Mica Ore
Mica Ore [End]
Miessiite Ore
Mithril Ore
Molybdenite Ore
Naquadah Ore
Naquadah Oxide Mixture Ore
Naquadria Ore
Naquadria Oxide Mixture Ore
Neodymium Ore
Neodymium Ore [End]
Neutronium Ore
Neutronium Ore [End]
Nichromite Ore
Nickel Ore
Nickel Ore [End]
Niobium Ore
Niobium Ore [End]
Olenite Ore
Olivine Ore
Orange Descloizite Ore
Orundum Ore
Palladium Metallic Powder Ore
Perlite Ore
Pig Iron Ore
Pitchblende Ore
Platinum Metallic Powder Ore
Polycrase Ore
Praseodymium Ore
Pyrope Ore
Quartzite Ore
Quartzite Ore [End]
Rare Earth (III) Ore
Rarest Metal Residue Ore
Red Fuchsite Ore
Red Garnet Ore
Redstone Ore
Redstone Ore [End]
Rock Salt Ore
Rock Salt Ore [End]
Roquesite Ore
Rubidium Ore
Rubracium Ore
Salt Ore
Salt Ore [End]
Samarium Ore
Samarskite (Y) Ore
Samarskite (Yb) Ore
Scheelite Ore
Silicon Solar Grade Ore
Silicon Solar Grade Ore [End]
Silver Ore
Sodalite Ore
Sodalite Ore [End]
Spodumene Ore
Strontium Ore
Tartarite Ore
Tellurium Ore
Tellurium Ore [End]
Temagamite Ore
Thorianite Ore
Thulium Ore
Thulium Ore [End]
Tiberium Ore
Tritanium Ore
Tungsten Ore
Tungsten Ore [End]
Uranium 235 Ore
Uranium 238 Ore
Uvarovite Ore
Vanadio-Oxy-Dravite Ore
Vanadium Magnetite Ore
Wittichenite Ore
Xenotime Ore
Yellow Garnet Ore
Yttriaite Ore
Yttrium Ore
Yttrium Ore [End]
Yttrocerite Ore
Zimbabweite Ore
Zircon Ore
`; // 15s (OW/M/C)

// const oresArray = [...document.querySelectorAll("td:nth-child(3) li")].map(el => el.innerText)
const ores10s = `
Adamantium Ore
Adamantium Ore [End]
Alburnite Ore
Alduorite Ore
Almandine Ore
Aluminium Fluoride Ore
Aluminium Ore
Aluminium Ore [End]
Alunite Ore
Amber Ore
Amethyst Ore
Amethyst Ore [End]
Andradite Ore
Antimony Ore
Antimony Ore [End]
Ardite Ore
Arsenic Ore
Arsenic Ore [End]
Atheneite Ore
Awakened Draconium Ore
Awakened Draconium Ore [End]
Banded Iron Ore
Barite (Ra) Ore
Basaltic Mineral Sand
Basaltic Mineral Sand [End]
Basaltic Mineral Sand [End]
Beryllium Ore
Bismuth Ore
Bismuth Ore [End]
Bismuthinite Ore
Bismutite Ore
Blue Topaz Ore
Blue Topaz Ore [End]
Brown Limonite Ore
Caesium Ore
Calcite Ore
Calcite Ore [End]
Calcium Disilicide Ore
Calcium Hydride Ore
Cassiterite Sand
Cassiterite Sand [End]
Cerite Ore
Cerium Ore
Ceruclase Ore
Cobalt Ore
Cobaltite Ore
Copper Ore
Copper Ore [End]
Crocoite Ore
Cryolite (F) Ore
Cryolite Ore
Deep Dark Iron Ore
Deep Iron Ore
Desh Ore
Desh Ore [End]
Djurleite Ore
Draconium Ore
Draconium Ore [End]
Duralumin Ore
Dysprosium Ore
Electrum Ore
Emery Ore
Erbium Ore
Fayalite Ore
Flerovium Ore
Fluorcaphite Ore
Fluorite (F) Ore
Fluxed Electrum Ore
Fluxed Electrum Ore [End]
Force Ore
Forsterite Ore
Gadolinium Ore
Gallium Ore
Gallium Ore [End]
Garnierite Ore
Garnierite Ore [End]
Granitic Mineral Sand
Granitic Mineral Sand [End]
Graphite Ore
Graphite Ore [End]
Green Fuchsite Ore
Grossular Ore
Gypsum Ore
Hibonite Ore
Honeaite Ore
Ichorium Ore
Ichorium Ore [End]
Infused Gold Ore
Infused Gold Ore [End]
Irarsite Ore
Jade Ore
Kaolinite
Kyanite
Lafossaite Ore
Lautarite Ore
Ledox Ore
Ledox Ore [End]
Lepersonnite Ore
Lithium Ore
Lithium Ore [End]
Lutetium Ore
Lutetium Ore [End]
Manganese Ore
Manyullyn Ore
Mirabilite Ore
Mysterious Crystal Ore
Mysterious Crystal Ore [End]
Mytryl Ore
Mytryl Ore [End]
Niter Ore
Orichalcum Ore
Oriharukon Ore
Oriharukon Ore [End]
Perroudite Ore
Phosphate Ore
Phosphate Ore [End]
Plutonium 239 Ore
Plutonium 241 Ore
Powellite Ore
Promethium Ore
Quantium Ore
Quantium Ore [End]
Rare Earth (I) Ore
Rare Earth (II) Ore
Raw Silicon Ore
Raw Silicon Ore [End]
Raw Tengam Ore
Realgar Ore
Red Zircon Ore
Roasted Iron Ore
Roasted Nickel Ore
Ruby Ore
Ruby Ore [End]
Runite Ore
Rutile Ore
Rutile Ore [End]
Saltpeter Ore
Saltpeter Ore [End]
Scandium Ore
Shadow Iron Ore
Shadow Iron Ore [End]
Shadow Metal Ore
Shadow Metal Ore [End]
Soapstone Ore
Spessartine Ore
Spinel Ore
Stibnite Ore
Sulfur Ore
Sulfur Ore [End]
Talc Ore
Tantalum Ore
Tantalum Ore [End]
Tanzanite Ore
Terbium Ore
Terlinguaite Ore
Tetrahedrite Ore
Thorium Ore
Titanite Ore
Titanium Ore
Titanium Ore [End]
Topaz Ore
Topaz Ore [End]
Trinium Ore
Trona Ore
Tungstate Ore
Tungstate Ore [End]
Uraninite Ore
Vanadium Ore
Vanadium Ore [End]
Vinteum Ore [End]
Vinteum Ore [End]
Vulcanite Ore
Vyroxeres Ore
Wollastonite Ore
Wulfenite Ore
Ytterbium Ore
Ytterbium Ore [End]
Yttrialite Ore
Zeolite Ore
Zerkelite Ore
Zirconolite Ore
`; // 10s (M/M/C) LARGEST

// const oresArray = [...document.querySelectorAll("td:nth-child(5) li")].map(el => el.innerText.split(", ")[1])
const oresOthers = `
Craft, Pumice Ore
Craft, Rubidium Ore
Line, Bastnasite Ore
Line, Bastnasite Ore [End]
Line, Monazite Ore
Line, Monazite Ore [End]
MABS, Molybdenum Ore
MABS, Molybdenum Ore [End]
MABS, Pyrite Ore
MABS, Pyrite Ore [End]
MABS, Sphalerite Ore
MABS, Sphalerite Ore [End]
MABS, Zinc Ore
MABS, Zinc Ore [End]
MEBF, Lead Ore
MEBF, Lead Ore [End]
Trash, Cheese Ore
Trash, Cheese Ore [End]
Trash, End Powder Ore
Trash, Endium Ore (GT)
Trash, Endium Ore (GT) [End]
Trash, Fluorspar Ore
Trash, Lignite Coal Ore
Trash, Lignite Coal Ore [End]
Trash, Oilsands Ore
`;
// #endregion Ore Lists
// Trash: (^ore.*(Lignite|Oilsands))

const ores = ores10s;
const oresArray = ores
  .trim()
  .split("\n")
  .map((ore) => ore.split(", ")[1] ?? ore);

/**
 * @param {string[]} oresArray
 */
const generateOreSet = (oresArray) => {
  // TODO
  // Cassiterite Sand -> 15s
  // Line, Bastnasite Ore
  // Line, Monazite Ore
  // MEBF, Lead Ore
  // MEBF, Lead Ore [End]
  // MABS, Molybdenum Ore
  // MABS, Molybdenum Ore [End]
  const oresSet = new Set();
  oresArray.forEach((ore) => {
    let truncatedOre = ore.replace(/\s?\[End\]/g, "");
    if (truncatedOre.startsWith("Rubidium")) {
      // Remove Rubidium Ore from processing
      return;
    }
    if (truncatedOre.endsWith("Stone")) {
      // Patch for Infused Stones in sifter
      oresSet.add("Infused[^(Gold)].*");
      return;
    }
    if (truncatedOre.startsWith("Shadow")) {
      // Patch for Infused Stones in sifter
      oresSet.add("Shadow.*");
      return;
    }
    if (truncatedOre.startsWith("DeepDarkIron")) {
      // Patch for Deep Dark Iron
      oresSet.add("DarkIron");
      return;
    }
    truncatedOre = truncatedOre.replace(/Ore.*/g, "").replace(/\s/g, "");
    // Patch for Raw ores
    truncatedOre = truncatedOre.replace("Raw", "");
    truncatedOre = truncatedOre.replace("Tengam", "TengamRaw");
    // Patch for Plutonium ores
    truncatedOre = truncatedOre.replace(/\s?(235|238|239|241)/g, "");
    // Patch for GT++ ores
    truncatedOre = truncatedOre.replace(/\s?\(.*\)/g, "");
    //? Shorten names
    // Patch for Enriched-NaquadahOxideMixture
    truncatedOre = truncatedOre.replace("NaquadahOxideMixture", "NaquadahO");
    // Patch for Chromo-Alumino-Povondraite
    truncatedOre = truncatedOre.replace(
      "Chromo-Alumino-Povondraite",
      "Chromo-Al"
    );
    // Patch for PalladiumMetallicPowder
    truncatedOre = truncatedOre.replace(
      "PalladiumMetallicPowder",
      "PalladiumMe"
    );
    oresSet.add(truncatedOre);
  });
  return oresSet;
};
const generateOreDicts = (oresSet) => {
  return `(^ore(Endstone)?(${[...oresSet].join("|")}))`;
};

const oreDictCardMaxLen = 256;
const oresSet = generateOreSet(oresArray);
const tempOreSet = new Set();
let oreDict = "";
let nextOreDict = "";
oresSet.forEach((ore) => {
  oreDict = generateOreDicts(tempOreSet);
  nextOreDict = generateOreDicts(new Set([...tempOreSet, ore]));

  if (nextOreDict.length > oreDictCardMaxLen) {
    console.log(oreDict);
    tempOreSet.clear();
  }

  tempOreSet.add(ore);
});
console.log(generateOreDicts(tempOreSet));
