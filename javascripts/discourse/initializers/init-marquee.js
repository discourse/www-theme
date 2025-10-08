import { apiInitializer } from "discourse/lib/api";
import Marquee from "../components/marquee";

export default apiInitializer((api) => {
  api.renderInOutlet("above-site-header", Marquee);
});
