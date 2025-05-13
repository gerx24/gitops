SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';
SET default_table_access_method = heap;



CREATE FOREIGN TABLE client_side.actives (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    mount_id uuid NOT NULL,
    release_id uuid NOT NULL
) SERVER crdb OPTIONS (
    table_name 'actives'
);


--
-- Name: mounts; Type: TABLE; Schema: client_side; Owner: -
--

CREATE FOREIGN TABLE client_side.mounts (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    name character varying(255) NOT NULL,
    paused boolean DEFAULT false NOT NULL
) SERVER crdb OPTIONS (
    table_name 'mounts'
);


--
-- Name: releases; Type: TABLE; Schema: client_side; Owner: -
--

CREATE FOREIGN TABLE client_side.releases (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    inserted_at timestamp without time zone NOT NULL,
    mount_id uuid NOT NULL,
    version character varying(255) NOT NULL,
    data jsonb DEFAULT '{}'::jsonb
) SERVER crdb OPTIONS (
    table_name 'releases'
);


--
-- Name: api_keys; Type: TABLE; Schema: public; Owner: -
--

CREATE FOREIGN TABLE public.api_keys (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    inserted_at timestamp without time zone NOT NULL,
    revoked_at timestamp without time zone,
    name character varying(255) NOT NULL,
    token bytea NOT NULL
) SERVER crdb OPTIONS (
    table_name 'api_keys'
);


--
-- Name: api_permissions; Type: TABLE; Schema: public; Owner: -
--

CREATE FOREIGN TABLE public.api_permissions (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    inserted_at timestamp without time zone NOT NULL,
    revoked_at timestamp without time zone,
    api_key_id uuid NOT NULL,
    tenant_id uuid NOT NULL
) SERVER crdb OPTIONS (
    table_name 'api_permissions'
);


--
-- Name: brands; Type: TABLE; Schema: public; Owner: -
--

CREATE FOREIGN TABLE public.brands (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    name character varying(255),
    code character varying(255) NOT NULL,
    number integer NOT NULL,
    display_name text DEFAULT ''::text NOT NULL
) SERVER crdb OPTIONS (
    table_name 'brands'
);


--
-- Name: collection_pages; Type: TABLE; Schema: public; Owner: -
--

CREATE FOREIGN TABLE public.collection_pages (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    brand_id uuid NOT NULL,
    tenant_id uuid,
    collection_id uuid NOT NULL,
    handle character varying(255) NOT NULL,
    page_title character varying(255) NOT NULL,
    description text,
    drupal_cms_path character varying(255),
    imported_cms_data jsonb DEFAULT '{}'::jsonb,
    cache_product_data boolean DEFAULT false,
    locale character varying(255) NOT NULL,
    status character varying(255)
) SERVER crdb OPTIONS (
    table_name 'collection_pages'
);


--
-- Name: collections; Type: TABLE; Schema: public; Owner: -
--

CREATE FOREIGN TABLE public.collections (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    name character varying(255) NOT NULL,
    lookup_criteria jsonb
) SERVER crdb OPTIONS (
    table_name 'collections'
);


--
-- Name: content_partials; Type: TABLE; Schema: public; Owner: -
--

CREATE FOREIGN TABLE public.content_partials (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    cms_source character varying(255),
    cms_source_id character varying(255),
    component character varying(255),
    mapped_data jsonb,
    tenant_id uuid,
    locale character varying(255) DEFAULT 'en_US'::character varying,
    vulcan_component character varying(255),
    cms_component character varying(255),
    content jsonb
) SERVER crdb OPTIONS (
    table_name 'content_partials'
);


--
-- Name: data_centers; Type: TABLE; Schema: public; Owner: -
--

CREATE FOREIGN TABLE public.data_centers (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    name character varying(255) NOT NULL,
    code character varying(255) NOT NULL,
    type character varying(255) NOT NULL
) SERVER crdb OPTIONS (
    table_name 'data_centers'
);


--
-- Name: fun_with_flags_toggles; Type: TABLE; Schema: public; Owner: -
--

CREATE FOREIGN TABLE public.fun_with_flags_toggles (
    flag_name character varying(255) NOT NULL,
    gate_type character varying(255) NOT NULL,
    target character varying(255) NOT NULL,
    enabled boolean NOT NULL,
    id uuid DEFAULT gen_random_uuid() NOT NULL
) SERVER crdb OPTIONS (
    table_name 'fun_with_flags_toggles'
);


--
-- Name: global_content_cms_source_references; Type: TABLE; Schema: public; Owner: -
--

CREATE FOREIGN TABLE public.global_content_cms_source_references (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    tenant_id uuid,
    locale character varying(255) NOT NULL,
    cms_source_ids character varying(255)[] DEFAULT ARRAY[]::character varying[]
) SERVER crdb OPTIONS (
    table_name 'global_content_cms_source_references'
);


--
-- Name: global_contents; Type: TABLE; Schema: public; Owner: -
--

CREATE FOREIGN TABLE public.global_contents (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    tenant_id uuid NOT NULL,
    locale character varying(255),
    content jsonb
) SERVER crdb OPTIONS (
    table_name 'global_contents'
);


--
-- Name: languages; Type: TABLE; Schema: public; Owner: -
--

CREATE TYPE public.script_direction AS ENUM (
    'left_to_right',
    'right_to_left'
);

CREATE FOREIGN TABLE public.languages (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    name character varying(255) NOT NULL,
    code character varying(255) NOT NULL,
    script character varying(255),
    direction public.script_direction DEFAULT 'left_to_right'::public.script_direction NOT NULL
) SERVER crdb OPTIONS (
    table_name 'languages'
);


--
-- Name: locale_languages; Type: TABLE; Schema: public; Owner: -
--

CREATE FOREIGN TABLE public.locale_languages (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    locale_id uuid,
    language_id uuid,
    is_default boolean DEFAULT false,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
) SERVER crdb OPTIONS (
    table_name 'locale_languages'
);


--
-- Name: locales; Type: TABLE; Schema: public; Owner: -
--

CREATE FOREIGN TABLE public.locales (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    region_id uuid,
    name character varying(255) NOT NULL,
    code character varying(255) NOT NULL,
    number integer NOT NULL,
    currency character varying(255) NOT NULL,
    supported_languages character varying(255)[]
) SERVER crdb OPTIONS (
    table_name 'locales'
);


--
-- Name: offer_versions; Type: TABLE; Schema: public; Owner: -
--

CREATE FOREIGN TABLE public.offer_versions (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    inserted_at timestamp without time zone NOT NULL,
    starts_at timestamp without time zone NOT NULL,
    ends_at timestamp without time zone,
    offer_id uuid NOT NULL,
    version bigint DEFAULT 1 NOT NULL,
    details jsonb DEFAULT '{}'::jsonb
) SERVER crdb OPTIONS (
    table_name 'offer_versions'
);


--
-- Name: offers; Type: TABLE; Schema: public; Owner: -
--

CREATE FOREIGN TABLE public.offers (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    inserted_at timestamp without time zone NOT NULL,
    tenant_id uuid NOT NULL,
    code text NOT NULL,
    active_version_id uuid
) SERVER crdb OPTIONS (
    table_name 'offers'
);


--
-- Name: page_cms_source_references; Type: TABLE; Schema: public; Owner: -
--

CREATE FOREIGN TABLE public.page_cms_source_references (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    tenant_id uuid,
    page_id uuid,
    cms_source_ids character varying(255)[] DEFAULT ARRAY[]::character varying[]
) SERVER crdb OPTIONS (
    table_name 'page_cms_source_references'
);


--
-- Name: page_sections; Type: TABLE; Schema: public; Owner: -
--

CREATE FOREIGN TABLE public.page_sections (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    cms_data jsonb,
    cms_section_id character varying(255),
    component character varying(255),
    mapped_data jsonb,
    page_id uuid,
    product_source_type character varying(255),
    product_source_value text,
    type character varying(255),
    "order" integer,
    vulcan_component character varying(255),
    cms_component character varying(255),
    content jsonb
) SERVER crdb OPTIONS (
    table_name 'page_sections'
);


--
-- Name: pages; Type: TABLE; Schema: public; Owner: -
--

CREATE FOREIGN TABLE public.pages (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    cms_source_id character varying(255),
    cms_source character varying(255),
    description character varying(255),
    layout character varying(255),
    locale character varying(255),
    page_section_order character varying(255)[],
    path character varying(255),
    product_source character varying(255),
    status character varying(255),
    tenant_id uuid,
    title character varying(255),
    type character varying(255),
    metadata jsonb
) SERVER crdb OPTIONS (
    table_name 'pages'
);


--
-- Name: product_details; Type: TABLE; Schema: public; Owner: -
--

CREATE FOREIGN TABLE public.product_details (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    data jsonb NOT NULL,
    locale_language_id uuid,
    product_id bigint
) SERVER crdb OPTIONS (
    table_name 'product_details'
);


--
-- Name: product_variant_details; Type: TABLE; Schema: public; Owner: -
--

CREATE FOREIGN TABLE public.product_variant_details (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    sku character varying(255),
    locale_language_id uuid,
    data jsonb NOT NULL
) SERVER crdb OPTIONS (
    table_name 'product_variant_details'
);


--
-- Name: product_variants; Type: TABLE; Schema: public; Owner: -
--

CREATE FOREIGN TABLE public.product_variants (
    sku character varying(255) NOT NULL,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    product_id bigint,
    material_code character varying(255) NOT NULL,
    upc character varying(255) NOT NULL
) SERVER crdb OPTIONS (
    table_name 'product_variants'
);


--
-- Name: products; Type: TABLE; Schema: public; Owner: -
--

CREATE FOREIGN TABLE public.products (
    id bigint NOT NULL,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    brand_id integer NOT NULL
) SERVER crdb OPTIONS (
    table_name 'products'
);


--
-- Name: products_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.products_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: products_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.products_id_seq OWNED BY public.products.id;


--
-- Name: regions; Type: TABLE; Schema: public; Owner: -
--

CREATE FOREIGN TABLE public.regions (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    name character varying(255) NOT NULL,
    code character varying(255) NOT NULL,
    number integer NOT NULL
) SERVER crdb OPTIONS (
    table_name 'regions'
);


--
-- Name: regions_data_centers; Type: TABLE; Schema: public; Owner: -
--

CREATE FOREIGN TABLE public.regions_data_centers (
    region_id uuid NOT NULL,
    data_center_id uuid NOT NULL
) SERVER crdb OPTIONS (
    table_name 'regions_data_centers'
);


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE FOREIGN TABLE public.schema_migrations (
    version bigint NOT NULL,
    inserted_at timestamp(0) without time zone
) SERVER crdb OPTIONS (
    table_name 'schema_migrations'
);


--
-- Name: shopkeeper_audit_logs; Type: TABLE; Schema: public; Owner: -
--

CREATE FOREIGN TABLE public.shopkeeper_audit_logs (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    inserted_at timestamp without time zone NOT NULL,
    shopkeeper_id uuid NOT NULL,
    action character varying(255) NOT NULL,
    email character varying(255) NOT NULL,
    params jsonb NOT NULL,
    remote_ip text,
    user_agent text
) SERVER crdb OPTIONS (
    table_name 'shopkeeper_audit_logs'
);


--
-- Name: shopkeeper_scopes; Type: TABLE; Schema: public; Owner: -
--

CREATE FOREIGN TABLE public.shopkeeper_scopes (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    shopkeeper_id uuid NOT NULL,
    scope character varying(255) NOT NULL,
    brand_id uuid,
    tenant_id uuid
) SERVER crdb OPTIONS (
    table_name 'shopkeeper_scopes'
);


--
-- Name: shopkeeper_sessions; Type: TABLE; Schema: public; Owner: -
--

CREATE FOREIGN TABLE public.shopkeeper_sessions (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    inserted_at timestamp without time zone NOT NULL,
    expires_at timestamp without time zone DEFAULT now() NOT NULL,
    shopkeeper_id uuid NOT NULL,
    token bytea NOT NULL
) SERVER crdb OPTIONS (
    table_name 'shopkeeper_sessions'
);


--
-- Name: shopkeepers; Type: TABLE; Schema: public; Owner: -
--

CREATE FOREIGN TABLE public.shopkeepers (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    inserted_at timestamp without time zone NOT NULL,
    email character varying(255) NOT NULL,
    granted boolean DEFAULT false NOT NULL
) SERVER crdb OPTIONS (
    table_name 'shopkeepers'
);


--
-- Name: static_assets; Type: TABLE; Schema: public; Owner: -
--

CREATE FOREIGN TABLE public.static_assets (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    tenant_id uuid NOT NULL,
    key text NOT NULL,
    location character varying(255) NOT NULL,
    checksum character varying(255) NOT NULL
) SERVER crdb OPTIONS (
    table_name 'static_assets'
);


--
-- Name: templates; Type: TABLE; Schema: public; Owner: -
--

CREATE FOREIGN TABLE public.templates (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    tenant_id uuid NOT NULL,
    key character varying(255) NOT NULL,
    content bytea NOT NULL,
    checksum character varying(255) NOT NULL
) SERVER crdb OPTIONS (
    table_name 'templates'
);


--
-- Name: tenants; Type: TABLE; Schema: public; Owner: -
--

CREATE FOREIGN TABLE public.tenants (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    domain character varying(255) NOT NULL,
    url character varying(255) NOT NULL,
    brand_id uuid,
    percent_of_traffic integer DEFAULT 0
) SERVER crdb OPTIONS (
    table_name 'tenants'
);


--
-- Name: tenants_locales; Type: TABLE; Schema: public; Owner: -
--

CREATE FOREIGN TABLE public.tenants_locales (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    tenant_id uuid NOT NULL,
    locale_id uuid NOT NULL,
    is_default boolean DEFAULT false NOT NULL
) SERVER crdb OPTIONS (
    table_name 'tenants_locales'
);


--
-- Name: account; Type: TABLE; Schema: settings; Owner: -
--

CREATE FOREIGN TABLE settings.account (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    tenant_id uuid,
    version character varying(255) DEFAULT '2'::character varying
) SERVER crdb OPTIONS (
    table_name 'account'
);


--
-- Name: analytics; Type: TABLE; Schema: settings; Owner: -
--

CREATE FOREIGN TABLE settings.analytics (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    tenant_id uuid NOT NULL,
    enabled boolean DEFAULT true,
    onetrust_api_key character varying(255) NOT NULL,
    tealium_profile character varying(255) NOT NULL,
    tealium_env character varying(255) NOT NULL,
    tealium_url character varying(255)
) SERVER crdb OPTIONS (
    table_name 'analytics'
);


--
-- Name: carts; Type: TABLE; Schema: settings; Owner: -
--

CREATE FOREIGN TABLE settings.carts (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    tenant_id uuid NOT NULL,
    enabled boolean DEFAULT true,
    page_checkout_url character varying(255) DEFAULT ''::character varying NOT NULL,
    page_go_shopping_url character varying(255) DEFAULT ''::character varying NOT NULL,
    page_is_read_only boolean DEFAULT false NOT NULL,
    drawer_checkout_url character varying(255) DEFAULT ''::character varying NOT NULL,
    drawer_enable_on_drupalgem boolean DEFAULT false NOT NULL,
    drawer_go_shopping_url character varying(255) DEFAULT ''::character varying NOT NULL,
    drawer_is_read_only boolean DEFAULT false NOT NULL,
    remove_free_items boolean DEFAULT false NOT NULL,
    remove_text_button boolean DEFAULT false NOT NULL,
    product_free_label boolean DEFAULT false NOT NULL,
    product_sample_label boolean DEFAULT false NOT NULL,
    drawer_product_title boolean DEFAULT false NOT NULL,
    "overlay" boolean DEFAULT false NOT NULL,
    mini_overlay boolean DEFAULT false NOT NULL,
    mini_overlay_subtotal boolean DEFAULT false NOT NULL,
    mini_overlay_qty_added_on_atb boolean DEFAULT false NOT NULL,
    redirect_to_checkout_on_empty boolean DEFAULT false NOT NULL,
    redirect_to_checkout_on_mobile boolean DEFAULT false NOT NULL,
    drawer_edit_button boolean DEFAULT false NOT NULL,
    overlay_footer_drupal_node_position_on_top boolean DEFAULT false NOT NULL,
    product_added_label boolean DEFAULT false NOT NULL,
    drawer_enable boolean DEFAULT false NOT NULL,
    overlay_footer_drupal_node_id character varying(255)[] DEFAULT ARRAY[]::character varying[],
    page_panel_bottom_node_id character varying(255)[] DEFAULT ARRAY[]::character varying[],
    page_summary_node_id character varying(255)[] DEFAULT ARRAY[]::character varying[],
    page_subtitle_node_id character varying(255)[] DEFAULT ARRAY[]::character varying[],
    enable_kit_details boolean DEFAULT false,
    enable_replenishment boolean DEFAULT false,
    page_payment_icons_node_id integer DEFAULT 0
) SERVER crdb OPTIONS (
    table_name 'carts'
);


--
-- Name: cdns; Type: TABLE; Schema: settings; Owner: -
--

CREATE FOREIGN TABLE settings.cdns (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    tenant_id uuid NOT NULL,
    enabled boolean DEFAULT false,
    media_base_url character varying(255) NOT NULL
) SERVER crdb OPTIONS (
    table_name 'cdns'
);


--
-- Name: checkouts; Type: TABLE; Schema: settings; Owner: -
--

CREATE FOREIGN TABLE settings.checkouts (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    tenant_id uuid NOT NULL,
    enabled boolean DEFAULT true,
    version character varying(255) NOT NULL,
    asset_key character varying(255),
    needs_signin_url character varying(255),
    needs_items_url character varying(255),
    enable_donation boolean DEFAULT false
) SERVER crdb OPTIONS (
    table_name 'checkouts'
);


--
-- Name: drupals; Type: TABLE; Schema: settings; Owner: -
--

CREATE FOREIGN TABLE settings.drupals (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    tenant_id uuid NOT NULL,
    enabled boolean DEFAULT true,
    published_base_url character varying(255) NOT NULL,
    auto_import boolean DEFAULT false,
    preview_password character varying(255),
    preview_username character varying(255),
    preview_base_url character varying(255),
    preview_base_url_enabled boolean DEFAULT false
) SERVER crdb OPTIONS (
    table_name 'drupals'
);


--
-- Name: endecas; Type: TABLE; Schema: settings; Owner: -
--

CREATE FOREIGN TABLE settings.endecas (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    tenant_id uuid NOT NULL,
    enabled boolean DEFAULT true,
    api_base_url character varying(255) NOT NULL,
    results_per_page character varying(255) DEFAULT '5'::character varying NOT NULL,
    server_name character varying(255),
    server_port character varying(255),
    typeahead_api_base_url character varying(255) DEFAULT ''::character varying,
    search_key character varying(255) DEFAULT 'all'::character varying NOT NULL
) SERVER crdb OPTIONS (
    table_name 'endecas'
);


--
-- Name: fredhoppers; Type: TABLE; Schema: settings; Owner: -
--

CREATE FOREIGN TABLE settings.fredhoppers (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    tenant_id uuid NOT NULL,
    enabled boolean DEFAULT true,
    base_search_url character varying(255) NOT NULL,
    base_suggest_url character varying(255) NOT NULL,
    catalog character varying(255) NOT NULL,
    password character varying(255) NOT NULL,
    resource_name character varying(255) NOT NULL,
    username character varying(255) NOT NULL,
    prepublished_base_search_url character varying(255),
    prepublished_base_search_url_enabled boolean DEFAULT false
) SERVER crdb OPTIONS (
    table_name 'fredhoppers'
);


--
-- Name: languages; Type: TABLE; Schema: settings; Owner: -
--

CREATE FOREIGN TABLE settings.languages (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    tenant_id uuid NOT NULL,
    enabled boolean DEFAULT true,
    "default" character varying(255) NOT NULL,
    supported character varying(255)[] NOT NULL
) SERVER crdb OPTIONS (
    table_name 'languages'
);


--
-- Name: live_persons; Type: TABLE; Schema: settings; Owner: -
--

CREATE FOREIGN TABLE settings.live_persons (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    tenant_id uuid NOT NULL,
    enabled boolean DEFAULT true,
    account_number character varying(255) NOT NULL,
    cstatus character varying(255) NOT NULL,
    ctype character varying(255) NOT NULL,
    tag_section character varying(255) NOT NULL,
    lp_button_link_div_id character varying(255) DEFAULT NULL::character varying,
    lp_text_link_div_id character varying(255) DEFAULT NULL::character varying,
    livechat_ui_enabled boolean DEFAULT false NOT NULL,
    livechat_ui_floating_button_text character varying(255),
    livechat_ui_beauty_button_text character varying(255),
    livechat_ui_beauty_button_loading_text character varying(255),
    livechat_ui_support_button_text character varying(255),
    livechat_ui_support_button_loading_text character varying(255),
    livechat_ui_drawer_area_text character varying(255),
    livechat_ui_error_message_text character varying(255),
    livechat_ui_cookie_message_text character varying(255)
) SERVER crdb OPTIONS (
    table_name 'live_persons'
);


--
-- Name: loyalties; Type: TABLE; Schema: settings; Owner: -
--

CREATE FOREIGN TABLE settings.loyalties (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    tenant_id uuid NOT NULL,
    display_loyalty_points boolean DEFAULT false NOT NULL,
    loyalty_points_multiplier integer DEFAULT 10 NOT NULL
) SERVER crdb OPTIONS (
    table_name 'loyalties'
);


--
-- Name: offers; Type: TABLE; Schema: settings; Owner: -
--

CREATE FOREIGN TABLE settings.offers (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    tenant_id uuid NOT NULL,
    enabled boolean DEFAULT true,
    drawer_enable_offer_code_module boolean NOT NULL,
    page_enable_offer_code_module boolean NOT NULL,
    page_enable_samples_module boolean NOT NULL,
    drawer_enable_samples_module boolean,
    enable_offers_tab boolean,
    rest_auth_token character varying(255)
) SERVER crdb OPTIONS (
    table_name 'offers'
);


--
-- Name: olapics; Type: TABLE; Schema: settings; Owner: -
--

CREATE FOREIGN TABLE settings.olapics (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    tenant_id uuid NOT NULL,
    enabled boolean DEFAULT true,
    apikey character varying(255) NOT NULL,
    url character varying(255) NOT NULL
) SERVER crdb OPTIONS (
    table_name 'olapics'
);


--
-- Name: optimizely_sdks; Type: TABLE; Schema: settings; Owner: -
--

CREATE FOREIGN TABLE settings.optimizely_sdks (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    tenant_id uuid NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    sdk_key character varying(255) DEFAULT ''::character varying NOT NULL
) SERVER crdb OPTIONS (
    table_name 'optimizely_sdks'
);


--
-- Name: optimizelys; Type: TABLE; Schema: settings; Owner: -
--

CREATE FOREIGN TABLE settings.optimizelys (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    tenant_id uuid NOT NULL,
    enabled boolean DEFAULT true,
    checkout_project_id character varying(255),
    project_id character varying(255),
    js_type character varying(255) DEFAULT 'Web only'::character varying NOT NULL
) SERVER crdb OPTIONS (
    table_name 'optimizelys'
);


--
-- Name: perlgems; Type: TABLE; Schema: settings; Owner: -
--

CREATE FOREIGN TABLE settings.perlgems (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    tenant_id uuid NOT NULL,
    enabled boolean DEFAULT true,
    brand_id integer NOT NULL,
    datacenter character varying(255) NOT NULL,
    region_id integer NOT NULL,
    has_loyalty boolean DEFAULT false
) SERVER crdb OPTIONS (
    table_name 'perlgems'
);


--
-- Name: pixlee; Type: TABLE; Schema: settings; Owner: -
--

CREATE FOREIGN TABLE settings.pixlee (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    tenant_id uuid NOT NULL,
    enabled boolean DEFAULT false,
    api_key character varying(255) DEFAULT ''::character varying NOT NULL,
    account_id character varying(255) DEFAULT ''::character varying NOT NULL,
    widget_id character varying(255) DEFAULT ''::character varying NOT NULL
) SERVER crdb OPTIONS (
    table_name 'pixlee'
);


--
-- Name: power_reviews; Type: TABLE; Schema: settings; Owner: -
--

CREATE FOREIGN TABLE settings.power_reviews (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    tenant_id uuid NOT NULL,
    enabled boolean DEFAULT true,
    apikey character varying(255) NOT NULL,
    base_url character varying(255) NOT NULL,
    merchant_group_id character varying(255) NOT NULL,
    merchant_id character varying(255) NOT NULL
) SERVER crdb OPTIONS (
    table_name 'power_reviews'
);


--
-- Name: recommendations; Type: TABLE; Schema: settings; Owner: -
--

CREATE FOREIGN TABLE settings.recommendations (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    tenant_id uuid NOT NULL,
    enabled boolean DEFAULT true,
    page_enable_recommended_for_you boolean NOT NULL,
    drawer_enable_recommended_for_you boolean NOT NULL,
    google_recommendations_enabled boolean DEFAULT false NOT NULL,
    google_recommendations_project_id character varying(255) DEFAULT ''::character varying NOT NULL,
    google_recommendations_api_key character varying(255) DEFAULT ''::character varying NOT NULL,
    abacus_recommendations_enabled boolean DEFAULT false NOT NULL,
    abacus_recommendations_deployment_id character varying(255) DEFAULT ''::character varying NOT NULL,
    abacus_recommendations_deployment_token character varying(255) DEFAULT ''::character varying NOT NULL
) SERVER crdb OPTIONS (
    table_name 'recommendations'
);


--
-- Name: seo; Type: TABLE; Schema: settings; Owner: -
--

CREATE FOREIGN TABLE settings.seo (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    tenant_id uuid NOT NULL,
    crawler_exclude_homepage boolean DEFAULT true,
    crawler_exclude_pdp boolean DEFAULT true,
    crawler_exclude_plp boolean DEFAULT true,
    hreflang_enabled boolean DEFAULT false,
    hreflang_default boolean DEFAULT false,
    bidirectional_enabled boolean DEFAULT false
) SERVER crdb OPTIONS (
    table_name 'seo'
);


--
-- Name: stardusts; Type: TABLE; Schema: settings; Owner: -
--

CREATE FOREIGN TABLE settings.stardusts (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    tenant_id uuid NOT NULL,
    enabled boolean DEFAULT true,
    business_unit_identifier character varying(255) NOT NULL,
    prodcat_api_base_url character varying(255) NOT NULL,
    graphql text DEFAULT ''::text
) SERVER crdb OPTIONS (
    table_name 'stardusts'
);


--
-- Name: templates; Type: TABLE; Schema: settings; Owner: -
--

CREATE FOREIGN TABLE settings.templates (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    tenant_id uuid NOT NULL,
    enabled boolean DEFAULT true,
    name character varying(255) NOT NULL,
    compile_at_startup boolean DEFAULT false
) SERVER crdb OPTIONS (
    table_name 'templates'
);


--
-- Name: translation_providers; Type: TABLE; Schema: settings; Owner: -
--

CREATE FOREIGN TABLE settings.translation_providers (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    tenant_id uuid NOT NULL,
    enabled boolean DEFAULT false,
    password character varying(255),
    username character varying(255)
) SERVER crdb OPTIONS (
    table_name 'translation_providers'
);


--
-- Name: turn_to; Type: TABLE; Schema: settings; Owner: -
--

CREATE FOREIGN TABLE settings.turn_to (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    tenant_id uuid NOT NULL,
    enabled boolean DEFAULT false,
    site_key character varying(255) DEFAULT ''::character varying NOT NULL
) SERVER crdb OPTIONS (
    table_name 'turn_to'
);


--
-- Name: vtos; Type: TABLE; Schema: settings; Owner: -
--

CREATE FOREIGN TABLE settings.vtos (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    tenant_id uuid NOT NULL,
    makeup_api_url character varying(255),
    makeup_api_key character varying(255),
    makeup_enabled boolean DEFAULT false,
    foundation_api_url character varying(255),
    foundation_api_key character varying(255),
    foundation_enabled boolean DEFAULT false,
    skincare_api_url character varying(255),
    skincare_api_key character varying(255),
    skincare_enabled boolean DEFAULT false,
    looks_api_url character varying(255),
    looks_api_key character varying(255),
    looks_enabled boolean DEFAULT false,
    hair_api_url character varying(255),
    hair_api_key character varying(255),
    hair_enabled boolean DEFAULT false,
    enabled boolean
) SERVER crdb OPTIONS (
    table_name 'vtos'
);


--
-- Name: white_labels; Type: TABLE; Schema: settings; Owner: -
--

CREATE FOREIGN TABLE settings.white_labels (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    tenant_id uuid NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    backorder_enabled boolean DEFAULT false NOT NULL,
    cms_provider character varying(255),
    product_provider character varying(255),
    merch_provider character varying(255),
    search_provider character varying(255)
) SERVER crdb OPTIONS (
    table_name 'white_labels'
);