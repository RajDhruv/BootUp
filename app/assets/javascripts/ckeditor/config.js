/**
 * @license Copyright (c) 2003-2019, CKSource - Frederico Knabben. All rights reserved.
 * For licensing, see https://ckeditor.com/legal/ckeditor-oss-license
 */

CKEDITOR.editorConfig = function( config ) {
	// Define changes to default configuration here. For example:
	// config.language = 'fr';
	// config.uiColor = '#AADC6E';
	config.language = 'en';
  	config.uiColor = '#ffffff';
  	config.embed_provider = '//ckeditor.iframe.ly/api/oembed?url={url}&callback={callback}';
  	config.removePlugins = "oembed";
};
