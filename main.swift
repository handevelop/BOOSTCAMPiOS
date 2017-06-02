/*
 * iOS 사전과제
 *
 * student.json 파일을 읽어 result.txt 파일로 출력하기
 * 
 * Ver.1.1
 * 
 * 2017-06-02
 *
 * Copyright 2017.handevelop all right reserved
 */

import Foundation

/*
 * json 파일에서 파싱한 학생의 정보를 담는 구조체
 * name -> name: String
 * data_structure -> dsScore: Int
 * algorithm -> algoScore: Int
 * networking -> nwScore: Int
 * database -> dbScore: Int
 * operating_system -> osScore: Int
 * 해당 학생이 수강한 과목의 수 -> cnt: Int
 *
 * init()은 초기값으로 각 멤버를  ""과 999, 0 으로 설정
 * 
 */
struct student{
	var name: String
	var dsScore: Int
	var algoScore: Int
	var nwScore: Int
	var dbScore: Int
	var osScore: Int
	var cnt: Int

	init() {
		name = ""
		dsScore = 999
		algoScore = 999
		nwScore = 999
		dbScore = 999
		osScore = 999
		cnt = 0
	}

}	
var str = student()
let path = "/home/dongjin/students.json"
var cnt = 1
/*파일을 열 수 있는지 확인 (필요 없어짐)
func fileInit() -> Void {
	//fileManger 선언
	let fileManager = FileManager.default
	do{
		if fileManager.fileExists(atPath: path){
			let isReadable = fileManager.isReadableFile(atPath: path)
			if isReadable {
				print("can read")
			}
		}
	}
}
*/
/*
 * student.json 파일내용을 스트링에 복사 후 배열로 파싱
 * 
 * parameter: Void, return: Array<String>
 *
 * 
 */
func jsonToArray() -> Array<String> {
	var emptyString = ""
	do{
		emptyString = try String(contentsOfFile: path, encoding: .utf8)
	} catch let error {
		print("\(error)")
	}
	// String.compoents(separatedBy: Any)
	// String을 구분자가 나올 때마다 배열의 원소로 넣음
	// 이 과제에서는 개행을 기준으로 원소로 넣는다.
	let parsedArray = emptyString.components(separatedBy: "\n")
	return parsedArray
}

/*
 * 파싱 되어 배열에 있는 name의 개수를 리턴해준다
 *
 * parameter: Array<String>, return: Int
 *
 */
func numberOfName(_ stuArray: Array<String>) -> Int {
	var cnt = 0
	for i in stuArray {
		if i.contains("name") {
			cnt += 1
		}
	}
	return cnt
}
/*
 * 문자열 안에 있는 콤마를 파싱해준다
 *
 * parameter: String, return: Int
 *
 */
func commaParse(_ parseString: String) -> Int {
	var result = 0
	let parsed = parseString.components(separatedBy: ",")
	if let score = Int(parsed[0]) {
		result = score
	}
	return result
}
/*
 * 문자열의 뒤부터 점수와 이름을 파싱해서 구조체에 넣어준다
 * 성공하면 1을 리턴, 실패하면 0을 리턴해 준다
 *
 * parameter: Array<String>, return: Int
 *
 */
func parseMajorScore(_ stuArray: Array<String>) -> Int {
	
	//뒤에서부터 파싱을 시작하여 name을 만나면 파싱을 멈춘다
	for _ in stuArray {
		let lastMember = (stuArray.count) - cnt
		cnt += 1
		if stuArray[lastMember].contains("operating_system") {
			str.cnt += 1
			let os = stuArray[lastMember]
			var osScore = os.components(separatedBy: "\"operating_system\": ")
			if osScore[1].contains(",") {
				//commaParse 호출
				let result = commaParse(osScore[1])
				str.osScore = result
			} else if let intOsScore = Int(osScore[1]) {
				str.osScore = intOsScore
			}
		} else if stuArray[lastMember].contains("database") {
			str.cnt += 1
			let db = stuArray[lastMember]
			var dbScore = db.components(separatedBy: "\"database\": ")
			if dbScore[1].contains(",") {
				//commaParse 호출
				let result = commaParse(dbScore[1])
				str.dbScore = result
			} else if let intDbScore = Int(dbScore[1]) {
				str.dbScore = intDbScore
			}
		} else if stuArray[lastMember].contains("networking") {
			str.cnt += 1
			let nw = stuArray[lastMember]
			var nwScore = nw.components(separatedBy: "\"networking\": ")
			if nwScore[1].contains(",") {
				//commaParse 호출
				let result = commaParse(nwScore[1])
				str.nwScore = result
			} else if let intNwScore = Int(nwScore[1]) {
				str.nwScore = intNwScore
			}
		} else if stuArray[lastMember].contains("algorithm") {
			str.cnt += 1
			let algo = stuArray[lastMember]
			var algoScore = algo.components(separatedBy: "\"algorithm\": ")
			if algoScore[1].contains(",") {
				//commaParse 호출
				let result = commaParse(algoScore[1])
				str.algoScore = result
			} else if let intAlgoScore = Int(algoScore[1]) {
				str.algoScore = intAlgoScore
			}
		} else if stuArray[lastMember].contains("data_structure") {
			str.cnt += 1
			let ds = stuArray[lastMember]
			var dsScore = ds.components(separatedBy: "\"data_structure\": ")
			if dsScore[1].contains(",") {
				//commaParse 호출
				let result = commaParse(dsScore[1])
				str.dsScore = result
			} else if let intDsScore = Int(dsScore[1]) {
				str.dsScore = intDsScore
			}
		} else if stuArray[lastMember].contains("name") {
			let name = stuArray[lastMember]
			var stuName = name.components(separatedBy: "\"name\": ")
			var tempName = stuName[1]
			tempName.remove(at: tempName.startIndex)
			tempName.remove(at: tempName.index(before: tempName.endIndex))
			tempName.remove(at: tempName.index(before: tempName.endIndex))
			str.name = tempName
			//cnt += 1
			return 1
		}
	}
	return 0
}
/*
 * 구조체를 초기화 해준다.
 *
 * parameter: Void, return: Void
 *
 */
func strInit() -> Void {
	str.name = ""
	str.dsScore = 999
	str.algoScore = 999
	str.nwScore = 999
	str.dbScore = 999
	str.osScore = 999
	str.cnt = 0
}
/*
 * 구조체에 있는 점수들을 더한 후  평균을 계산해준다.
 *
 * parameter: Void, return: Double
 *
 */
func avgGet() -> Double {
	var sum = 0.0
	if str.dsScore != 999 {
		sum += Double(str.dsScore)
	}
	if str.algoScore != 999 {
		sum += Double(str.algoScore)
	}
	if str.nwScore != 999 {
		sum += Double(str.nwScore)
	}
	if str.dbScore != 999 {
		sum += Double(str.dbScore)
	}
	if str.osScore != 999 {
		sum += Double(str.osScore)
	}

	return sum/Double(str.cnt)
}
/*
 * 매개변수로 받은 평균을 가지고 평점(GPA)을 구해 리턴한다.
 *
 * parameter: Double, return: String
 *
 */
func getGPA(_ avg: Double) -> String {
	let GPA: String
	switch avg {
		case 90..<101:
			GPA = "A"
		case 80..<90:
			GPA = "B"
		case 70..<80:
			GPA = "C"
		case 60..<70:
			GPA = "D"
		default:
			GPA = "F"
	}
	return GPA
}
//fileInit()

/*
 *
 * 전체적인 모식도
 *
 * 1. jsonToArray()로 myArray라는 배열에 json의 내용을 파싱한다.
 * 2. myArray에 있는 "name"의 수만큼 반복하여 parseMajorScore()로 성적들을 파싱한다.
 * 3. 파싱 한 데이터를 nameAndGPA 딕셔너리에 넣어준다.
 * 4. 이 과정 중에 getGPA() 와 avgGet()을 이용하여 학생들의 GPA와 수료생이 누구인지 구한다.
 * 5. nameAndGPA 딕셔너리의 key 값인 이름을 내림차순으로 정렬한다.
 * 6. 학생들의 평균, 정렬된 데이터, 수료생 들을 파일에 출력한다.
 *
 */
var myArray = jsonToArray()
var cntName = numberOfName(myArray)
var totalSum = 0.0
var nameAndGPA: [String: String] = [String: String]()
var passStudent = Array<String>()
while cntName > 0 {
	strInit()
	var result = parseMajorScore(myArray)
	if result == 1 {
		let GPA = getGPA(avgGet())
		nameAndGPA["\(str.name)"] = GPA
		if GPA == "A" {
			passStudent.append(str.name)
		} else if GPA == "B" {
			passStudent.append(str.name)
		} else if GPA == "C" {
			passStudent.append(str.name)
		}
	}
	totalSum += avgGet()
	result = 0
	cntName -= 1
}
//double의 소수점 둘째자리 까지 표현하는 방법
//1.멀티 플라이어와 round 이용
//2.String(format: , )을 이용

let numberOfPlaces = 2.0
let multiplier = pow(10.0, numberOfPlaces)
var totalAvg = totalSum/Double(numberOfName(myArray))
//print(String(format: "%3.2f", totalAvg))
totalAvg = round(totalAvg * multiplier) / multiplier
var sorted = nameAndGPA.sorted{$0<$1}
//쓰기 위한 파일 열기
var pathToWrite = "/home/dongjin/result.txt"
let fileManager = FileManager.default
if fileManager.createFile(atPath: pathToWrite, contents: nil, attributes: nil) {
	print("파일 생성 완료!")
} else {
	print("파일 생성 실패!")
}
let fileHandler: FileHandle? = FileHandle(forWritingAtPath: pathToWrite)
let data = ("성적결과표\n\n전체 평균 : " as NSString).data(using: String.Encoding.utf8.rawValue)
fileHandler?.write(data!)
let avgData = ("\(totalAvg)\n\n개인별 학점\n").data(using: .utf8, allowLossyConversion: false)
fileHandler?.write(avgData!)
for (key, value) in sorted {
	let keyData = ("\(key)").data(using: .utf8, allowLossyConversion: false)
	fileHandler?.write(keyData!)
	var nameCount = key.characters.count
	while nameCount < 11 {
		let spaceData = (" " as NSString).data(using: String.Encoding.utf8.rawValue)
		fileHandler?.write(spaceData!)
		nameCount += 1
	}
	let valueData = (": \(value)\n").data(using: .utf8, allowLossyConversion: false)
	fileHandler?.write(valueData!)
}
let pass = ("\n수료생\n" as NSString).data(using: String.Encoding.utf8.rawValue)
fileHandler?.write(pass!)
for i in passStudent {
	if i != passStudent[passStudent.endIndex-1] {
		let passData = ("\(i), ").data(using: .utf8, allowLossyConversion: false)
		fileHandler?.write(passData!)
	} else {
		let passData = ("\(i)\n").data(using: .utf8, allowLossyConversion: false)
		fileHandler?.write(passData!)
	}
}
