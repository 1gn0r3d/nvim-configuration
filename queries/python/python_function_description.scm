(function_definition 
  name: (identifier) @function.name
  parameters: (parameters
    (typed_parameter
      (identifier) @typ_param.name
      type: (type) @typ_param.type)?
    (default_parameter
      name: (identifier) @def_param.name
      value: (_) @def_param.default)?
    (typed_default_parameter 
      name: (identifier) @typ_def_param.name
      type: (type) @typ_def_param.type
      value: (_) @typ_def_param.default)?
    ((identifier) @param.name)?) ; for untyped, non default parameters
      return_type: (type)? @function.return_type)
