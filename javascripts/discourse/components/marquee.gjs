import Component from "@glimmer/component";
import { tracked } from "@glimmer/tracking";
import { action } from "@ember/object";
import { inject as service } from "@ember/service";
import didInsert from "@ember/render-modifiers/modifiers/did-insert";

export default class Marquee extends Component {
  @service store;

  @tracked latestTopics = [];
  @tracked isLoading = true;

  constructor() {
    super(...arguments);
    this.fetchLatestTopics();
  }

  async fetchLatestTopics() {
    this.isLoading = true;

    try {
      const response = await this.store.findFiltered("topicList", {
        filter: "latest",
        params: {},
      });

      this.latestTopics = response.topics.slice(0, 5);
    } catch (error) {
      console.error("Error fetching latest topics:", error);
    } finally {
      this.isLoading = false;
    }
  }

  get formattedTopics() {
    return this.latestTopics.map((topic) => ({
      url: `/t/${topic.slug}/${topic.id}/${topic.last_read_post_number}`,
      title: topic.title,
    }));
  }

  <template>
    <div id="latest-topics-bar">
      {{#if this.isLoading}}
        <div class="loading-spinner">Loading...</div>
      {{else}}
        <div>
          <ul>
            {{#each this.formattedTopics as |topic|}}
              <li>
                <a href={{topic.url}}>{{topic.title}}</a>
              </li>
            {{/each}}
          </ul>
          <ul>
            {{#each this.formattedTopics as |topic|}}
              <li>
                <a href={{topic.url}}>{{topic.title}}</a>
              </li>
            {{/each}}
          </ul>
        </div>
      {{/if}}
    </div>
  </template>
}
