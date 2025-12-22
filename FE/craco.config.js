module.exports = {
	webpack: {
		configure: (webpackConfig) => {
			// Chặn các warning kiểu "Failed to parse source map"
			webpackConfig.ignoreWarnings = [
				...(webpackConfig.ignoreWarnings || []),
				/Failed to parse source map/,
			];
			return webpackConfig;
		},
	},
};
