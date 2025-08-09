// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation

// Ambil diff dari git
func runGitDiff() -> String {
    let task = Process()
    task.launchPath = "/usr/bin/env"
    task.arguments = ["git", "diff", "--cached"]

    let pipe = Pipe()
    task.standardOutput = pipe
    task.launch()
    task.waitUntilExit()

    let data = pipe.fileHandleForReading.readDataToEndOfFile()
    return String(data: data, encoding: .utf8) ?? ""
}

func callGeminiAPI(diff: String) -> String? {
    guard let apiKey = ProcessInfo.processInfo.environment["GEMINI_API_KEY"], !apiKey.isEmpty else {
        print("❌ API key tidak ditemukan. Set di environment variable GEMINI_API_KEY.")
        return nil
    }
    
    let url = URL(string: "https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash:generateContent?key=\(apiKey)")!
    let prompt = "Generate concise git commit message for:\n\(diff)"

    let payload: [String: Any] = [
        "contents": [["parts": [["text": prompt]]]]
    ]
    
    guard let jsonData = try? JSONSerialization.data(withJSONObject: payload) else { return nil }
    
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    request.httpBody = jsonData

    let semaphore = DispatchSemaphore(value: 0)
    var result: String?

    URLSession.shared.dataTask(with: request) { data, _, error in
        defer { semaphore.signal() }
        
        guard error == nil, let data = data,
              let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
              let candidates = json["candidates"] as? [[String: Any]],
              let textParts = (candidates.first?["content"] as? [String: Any])?["parts"] as? [[String: Any]],
              let text = textParts.first?["text"] as? String else {
            print("❌ Gagal mendapatkan response dari API")
            return
        }
        
        result = text.trimmingCharacters(in: .whitespacesAndNewlines)
    }.resume()

    semaphore.wait()
    return result
}
func runGitCommit(message: String) {
    let task = Process()
    task.launchPath = "/usr/bin/env"
    task.arguments = ["git", "commit", "-m", message]
    task.launch()
    task.waitUntilExit()
}

// Main Execution
let diff = runGitDiff()
if diff.isEmpty {
    print("⚠️ Tidak ada perubahan untuk di-commit.")
    exit(0)
}

if let commitMsg = callGeminiAPI(diff: diff) {
    runGitCommit(message: commitMsg)
    print("✅ Commit berhasil: \(commitMsg)")
} else {
    print("❌ Gagal membuat commit message.")
}

