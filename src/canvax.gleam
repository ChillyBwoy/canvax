import canvax/canvas/context.{type CanvasRenderingContext2D}
import canvax/html.{type HTMLCanvasElement}
import canvax/scene.{type NodeList}
import gleam/list

pub type CanvaxError {
  NoRootElement
  NoContext
}

pub opaque type CanvaxApp {
  CanvaxApp(el: HTMLCanvasElement, ctx: CanvasRenderingContext2D)
}

type CreateNodeList(rc) =
  fn(HTMLCanvasElement, CanvasRenderingContext2D) -> #(rc, NodeList(rc))

pub fn create_app(root el_id: String) -> Result(CanvaxApp, CanvaxError) {
  case html.get_element_by_id(el_id) {
    Error(_) -> Error(NoRootElement)
    Ok(el) -> {
      case context.get_context(el) {
        Error(_) -> Error(NoContext)
        Ok(ctx) -> {
          CanvaxApp(el, ctx) |> Ok()
        }
      }
    }
  }
}

pub fn run(app: CanvaxApp, create_node_list: CreateNodeList(rc)) {
  let #(render_context, node_list) = create_node_list(app.el, app.ctx)

  html.raf(fn(_frame) {
    list.each(node_list, fn(node) { node(app.ctx, render_context) })

    Nil
  })
}
