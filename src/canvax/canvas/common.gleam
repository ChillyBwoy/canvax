pub type Path2D

pub type PredefinedColorSpace {
  DisplayP3
  SRGB
}

pub fn predefined_color_space(model: PredefinedColorSpace) -> String {
  case model {
    DisplayP3 -> "display-p3"
    SRGB -> "srgb"
  }
}

pub type DOMMatrix2DInit
