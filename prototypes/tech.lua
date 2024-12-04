data:extend(
{
  {
	type = "technology",
    name = "planet-discovery-sunorbit",
    icon = "__slp-dyson-sphere-reworked__/graphics/tech/sun.png",
    icon_size = 512,
    essential = true,
    effects =
    {
      {
        type = "unlock-space-location",
        space_location = "slp-solar-system-sun",
        use_icon_overlay_constant = true
      },
	  {
        type = "unlock-recipe",
        recipe = "slp-sun-fuel"
      }
    },
    prerequisites = {"planet-discovery-vulcanus"},
    unit =
    {
      count = 1000,
      ingredients =
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
        {"chemical-science-pack", 1},
        {"space-science-pack", 1},
        {"metallurgic-science-pack", 1}
      },
      time = 30
    }
  },
  {
	type = "technology",
    name = "slp-sunpack",
    icon = "__slp-dyson-sphere-reworked__/graphics/tech/sun-science-pack-tech.png",
    icon_size = 256,
    essential = true,
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "slp-sun-science-pack"
      }
    },
    prerequisites = {"planet-discovery-sunorbit", "electromagnetic-plant"},
    research_trigger =
    {
      type = "craft-item",
      item = "slp-sun-fuel",
	    count = 10
    }
  },
  {
	type = "technology",
    name = "slp-fuel-mk2",
    icon = "__slp-dyson-sphere-reworked__/graphics/tech/plasma-fuel.png",
    icon_size = 256,
    essential = false,
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "slp-sun-fuel-mk2"
      }
    },
    prerequisites = {"slp-sunpack", "advanced-asteroid-processing"},
    unit =
    {
      count = 500,
      ingredients =
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
        {"chemical-science-pack", 1},
        {"space-science-pack", 1},
        {"slp-sun-science-pack", 1}
      },
      time = 60
    }
  },
  {
	  type = "technology",
    name = "slp-solar-system-sun2",
    icon = "__slp-dyson-sphere-reworked__/graphics/tech/sun2.png",
    icon_size = 512,
    essential = false,
    effects =
    {
      {
        type = "unlock-space-location",
        space_location = "slp-solar-system-sun2",
        use_icon_overlay_constant = true
      },
      {
        type = "unlock-recipe",
        recipe = "slp-ds-thruster-fuel-double"
      },
      {
        type = "unlock-recipe",
        recipe = "slp-ds-thruster-oxidizer-double"
      },
    },
    prerequisites = {"slp-sunpack", "rocket-turret", "laser-turret", "advanced-asteroid-processing"},
    unit =
    {
      count = 2000,
      ingredients =
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
        {"chemical-science-pack", 1},
        {"space-science-pack", 1},
        {"production-science-pack", 1},
        {"utility-science-pack", 1},
        {"slp-sun-science-pack", 1},
      },
      time = 60
    }
  },
  {
	  type = "technology",
    name = "slp-dyson-sphere",
    icon = "__slp-dyson-sphere-reworked__/graphics/tech/dyson-sphere.png",
    icon_size = 512,
    essential = false,
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "ds-entangled-core"
      },
      {
        type = "unlock-recipe",
        recipe = "slp-ds-satellite"
      },
      {
        type = "unlock-recipe",
        recipe = "ds-energy-small-loader"
      }
    },
    prerequisites = {"slp-sunpack", "slp-solar-system-sun2", "metallurgic-science-pack", "nuclear-power"},
    unit =
    {
      count = 1000,
      ingredients =
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
        {"chemical-science-pack", 1},
        {"space-science-pack", 1},
        {"production-science-pack", 1},
        {"utility-science-pack", 1},
        {"agricultural-science-pack", 1},
        {"electromagnetic-science-pack", 1},
        {"metallurgic-science-pack", 1},
        {"slp-sun-science-pack", 1},
      },
      time = 60
    }
  },
  {
	  type = "technology",
    name = "slp-dyson-sphere-grounded",
    icon = "__slp-dyson-sphere-reworked__/graphics/ds-energy-big-loader/icon-mk1.png",
    icon_size = 512,
    essential = false,
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "slp-ds-planet-satellite"
      },
      {
        type = "unlock-recipe",
        recipe = "ds-energy-loader-mk1"
      }
    },
    prerequisites = {"slp-dyson-sphere", "lithium-processing"},
    unit =
    {
      count = 1500,
      ingredients =
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
        {"chemical-science-pack", 1},
        {"space-science-pack", 1},
        {"production-science-pack", 1},
        {"utility-science-pack", 1},
        {"agricultural-science-pack", 1},
        {"electromagnetic-science-pack", 1},
        {"metallurgic-science-pack", 1},
        {"slp-sun-science-pack", 1},
      },
      time = 60
    }
  },
  {
	  type = "technology",
    name = "ds-energy-loader-mk2",
    icon = "__slp-dyson-sphere-reworked__/graphics/ds-energy-big-loader/icon-mk2.png",
    icon_size = 512,
    essential = false,
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "ds-energy-loader-mk2"
      }
    },
    prerequisites = {"slp-dyson-sphere-grounded", "quantum-processor"},
    unit =
    {
      count = 1000,
      ingredients =
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
        {"chemical-science-pack", 1},
        {"space-science-pack", 1},
        {"production-science-pack", 1},
        {"utility-science-pack", 1},
        {"agricultural-science-pack", 1},
        {"electromagnetic-science-pack", 1},
        {"metallurgic-science-pack", 1},
        {"cryogenic-science-pack", 1},
        {"slp-sun-science-pack", 1},
      },
      time = 60
    }
  },
  {
	  type = "technology",
    name = "ds-energy-loader-mk3",
    icon = "__slp-dyson-sphere-reworked__/graphics/ds-energy-big-loader/icon-mk3.png",
    icon_size = 512,
    essential = false,
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "ds-energy-loader-mk3"
      }
    },
    prerequisites = {"ds-energy-loader-mk2", "promethium-science-pack"},
    unit =
    {
      count = 3000,
      ingredients =
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
        {"chemical-science-pack", 1},
        {"space-science-pack", 1},
        {"production-science-pack", 1},
        {"utility-science-pack", 1},
        {"agricultural-science-pack", 1},
        {"electromagnetic-science-pack", 1},
        {"metallurgic-science-pack", 1},
        {"cryogenic-science-pack", 1},
        {"promethium-science-pack", 1},
        {"slp-sun-science-pack", 1},
      },
      time = 60
    }
  },
})