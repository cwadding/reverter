module Reverter
	module Controllers
		module FlashNotice
			def flash_notice(item, options = {})
				verb = caller_locations(1,1)[0].label
				options.merge!({:class => "btn btn-mini btn-danger", form_class: "pull-right"})
				if item.is_a? Array
					msg = I18n.t("reverter.flash.notice.other", model: item.first.class.model_name.human.pluralize, verb: past_tensify(verb), count: item.count)
					msg = undo_link(item, options).html_safe + msg if item.first.respond_to?(:versions)
				else
					msg = I18n.t("reverter.flash.notice.one", model: item.class.model_name.human, verb: past_tensify(verb))
					msg = undo_link(item, options) + msg if item.respond_to?(:versions)
				end
				msg
			end

			def undo_link(item, options= {})
				if item.is_a? Array
					form_class = options.delete(:form_class)
					item.map{|i| view_context.hidden_field_tag("ids[]", i)}
					view_context.form_tag(reverter.revert_version_path(item.first.versions.last), :class => form_class) do
						view_context.raw(item.join("") + view_context.submit_tag(I18n.t("reverter.links.undo"), options))
					end
				else
					view_context.button_to(I18n.t("reverter.links.undo"), reverter.revert_version_path(item.versions.last), options)
				end
			end

			def past_tensify(verb)
				I18n.t("reverter.actions.past-tense.#{verb.parameterize}")
			end
		end
	end
end