Return-Path: <linux-s390+bounces-5531-lists+linux-s390=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F0A694D3C2
	for <lists+linux-s390@lfdr.de>; Fri,  9 Aug 2024 17:40:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B189E1F21AE9
	for <lists+linux-s390@lfdr.de>; Fri,  9 Aug 2024 15:40:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EE3D198A21;
	Fri,  9 Aug 2024 15:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="YECeYLsV"
X-Original-To: linux-s390@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A2821922CD;
	Fri,  9 Aug 2024 15:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723217994; cv=none; b=S84I/zQdV91zeHCFCIm4e9YPdShLE++4DkF66lq2jgezGu8UO5q7S7w/Lk9iYBpFfHTzY+pNG7x3Nc39EUDFt3Vpu8k5aPFAm/U6R/xoSH1pqXK+yWFD5JwPwSSuGW+XYvZZV/plCWEQK8DeubMduNZt8xztouZbWm8E2KlViqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723217994; c=relaxed/simple;
	bh=TLpJsiKmeS1itxanDPbIYMhASh/6HsH6VHYF3q/6PO8=;
	h=Content-Type:Subject:From:In-Reply-To:Date:Cc:Message-Id:
	 References:To:MIME-Version; b=bKuNBJeTxAHO5s47GKE9repK+cNb2gJdXHkFjVXrVCvtTfdR71nyjb7crLeHN8NvCno0ruOlPPGQhRWdRINJ6i9p/eauZ95omezQEIuwDawbLFVRV1ZAV1JTtTYlLrqRlFeysmEsbysjiIkK7Bdtb6dV1xnef+Y0OO+sbxB0wfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com; spf=none smtp.mailfrom=linux.vnet.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=YECeYLsV; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.vnet.ibm.com
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47927qVs012438;
	Fri, 9 Aug 2024 15:39:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-type:subject:from:in-reply-to:date:cc:message-id
	:references:to:content-transfer-encoding:mime-version; s=pp1;
	 bh=CQ5vYN2zycF2NisNzQnQlk6p5VFwwC2IDFoIE1a52e4=; b=YECeYLsV7AAg
	pF8+h77VKzvVleDtRu4bSKwvXYx8O8gqFFJEIa5EXJ1HWNBaXNli1o1nVo5WAFsN
	680f6gxqlM8b4AHfglAzR3DwcVbbO/5M9tV1KV539MCl9iARxKQ0L0gIxp+m1yLY
	PhF+TqLppmEHS0MtBXsgIeaUi3TzlZWhyVrOgeI8Hl4Gazav6Vs8OoQ1wDB2q+TD
	gUgkuFkQs+MngxsCMyZvtV2/MaYtF4Dl6swue6ScPCt1noiGfsj1g6t8vQ1wPo+r
	jPzeBpb8TaryZOvqj5DAbxxuhucCesazOgduGfp3cEcZ/Q3P5wOYbGwwOB+OfgGj
	dz8cRHqE8A==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40vwkcb6ux-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 Aug 2024 15:39:20 +0000 (GMT)
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 479FdJ7E012836;
	Fri, 9 Aug 2024 15:39:19 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40vwkcb6uv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 Aug 2024 15:39:19 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 479FFF0q024314;
	Fri, 9 Aug 2024 15:39:18 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 40sy914bja-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 Aug 2024 15:39:18 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 479FdCr954133024
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 9 Aug 2024 15:39:14 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 180A52004B;
	Fri,  9 Aug 2024 15:39:12 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7D7F620043;
	Fri,  9 Aug 2024 15:39:04 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.61.57.29])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri,  9 Aug 2024 15:39:04 +0000 (GMT)
Content-Type: text/plain;
	charset=utf-8
Subject: Re: [PATCHSET 00/10] perf tools: Sync tools and kernel headers for
 v6.11
From: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
In-Reply-To: <ZrUSCFLWDg9iJ_23@google.com>
Date: Fri, 9 Aug 2024 21:08:50 +0530
Cc: Leo Yan <leo.yan@arm.com>, James Clark <james.clark@linaro.org>,
        Kajol Jain <kjain@linux.ibm.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-s390@vger.kernel.org
Message-Id: <56008678-7B06-4E54-8447-1C0DCBC15521@linux.vnet.ibm.com>
References: <20240806225013.126130-1-namhyung@kernel.org>
 <ZrO5HR9x2xyPKttx@google.com>
 <F3C6DE61-8E10-4814-A6C0-C7569B3FD613@linux.vnet.ibm.com>
 <ZrUSCFLWDg9iJ_23@google.com>
To: Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
X-Mailer: Apple Mail (2.3774.600.62)
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: dFzNbUi65ljJENPKSlFBOuM9lMdJrV7K
X-Proofpoint-ORIG-GUID: GMbLGUIBQ8rikTIWTw2WrduGxoCXnU7w
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-09_12,2024-08-07_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 bulkscore=0 clxscore=1015 impostorscore=0 suspectscore=0 phishscore=0
 malwarescore=0 adultscore=0 spamscore=0 mlxlogscore=855 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2408090113



> On 9 Aug 2024, at 12:14=E2=80=AFAM, Namhyung Kim <namhyung@kernel.org> wr=
ote:
>=20
> Hello,
>=20
> On Thu, Aug 08, 2024 at 12:14:12PM +0530, Athira Rajeev wrote:
>>=20
>>=20
>>> On 7 Aug 2024, at 11:42=E2=80=AFPM, Namhyung Kim <namhyung@kernel.org> =
wrote:
>>>=20
>>> Hello folks,
>>>=20
>>> On Tue, Aug 06, 2024 at 03:50:03PM -0700, Namhyung Kim wrote:
>>>> Hello,
>>>>=20
>>>> This is the usual sync up in header files we keep in tools directory.
>>>> I put a file to give the reason of this work and not to repeat it in
>>>> every commit message.  The changes will be carried in the perf-tools
>>>> tree.
>>>=20
>>> Could you please double check what's in the tmp.perf-tools branch at the
>>> perf-tools tree so I don't break build and perf trace for arm64, powerpc
>>> and s390?  It has this patchset + arm64 unistd header revert (according
>>> to the discussion on patch 6/10) on top of v6.11-rc2.
>>>=20
>>> Thanks,
>>> Namhyung
>> Hi Namhyung,
>>=20
>> Can you please point to the tree. I checked in https://git.kernel.org/pu=
b/scm/linux/kernel/git/acme/linux.git as well as https://git.kernel.org/pub=
/scm/linux/kernel/git/perf/perf-tools-next.git , but didn=E2=80=99t find th=
e changes. May be I am missing something. I am trying to check the build in=
 powerpc.
>=20
> Oh, sorry about that.  It's in:
> https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools.git
>=20
> (no -next at the end)

Hi,

I did compile test on powerpc and results are good.=20

Tested-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>

Thanks
Athira
>=20
> Thanks,
> Namhyung



