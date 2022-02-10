import 'dart:developer';

abstract class IModel<PARAMS, RETURN> {
  RETURN model({required PARAMS params});
}

abstract class IView<MODEL, RETURN> {
  RETURN view({required MODEL model});
}

abstract class IPresenter<PARAMS, MODEL, VIEW, RETURN>
    implements IModel<PARAMS, MODEL>, IView<MODEL, VIEW> {
  RETURN presenter(PARAMS params) {
    log(
      '$params',
      name: 'PRESENTER - PARAMS: ${(runtimeType.toString()).toString()}',
    );

    final MODEL modelData = model(params: params);
    log(
      '$modelData',
      name: 'MODEL: ${(runtimeType.toString()).toString()}',
    );

    final VIEW viewData = view(model: modelData);
    log(
      '$viewData',
      name: 'VIEW: ${(runtimeType.toString()).toString()}',
    );

    return viewData as RETURN;
  }
}
