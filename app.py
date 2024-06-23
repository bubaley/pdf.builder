from io import BytesIO

from flask import Flask, request, send_file, jsonify
import pdfkit

app = Flask(__name__)


@app.route('/api/build_from_html', methods=['POST'])
def build_from_html():
    try:
        data = request.get_json()
        content = str(data.get('content'))
        options = {
            '--enable-local-file-access': True,
            # '--enable-external-links': True,
            'page-size': 'A4',
            'margin-top': '1.5cm',
            'margin-right': '1cm',
            'margin-bottom': '1cm',
            'margin-left': '1cm',
        }

        kek = pdfkit.from_string(content, options=options)
        pdf_buffer = BytesIO(kek)
        pdf_buffer.seek(0)
        return send_file(pdf_buffer, as_attachment=True, download_name='output.pdf', mimetype='application/pdf')
    except TypeError as e:
        print(e)
        return jsonify({'error': 'invalid content'}), 400
    except Exception as e:
        return jsonify({'error': str(e)}), 400


if __name__ == '__main__':
    app.run(debug=False)
