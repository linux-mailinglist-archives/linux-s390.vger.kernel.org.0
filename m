Return-Path: <linux-s390+bounces-275-lists+linux-s390=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A713801037
	for <lists+linux-s390@lfdr.de>; Fri,  1 Dec 2023 17:36:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D5291F20F74
	for <lists+linux-s390@lfdr.de>; Fri,  1 Dec 2023 16:36:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9BC63C065;
	Fri,  1 Dec 2023 16:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="C0gscrXN"
X-Original-To: linux-s390@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1621BCF;
	Fri,  1 Dec 2023 08:36:08 -0800 (PST)
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B1GZEtB030157;
	Fri, 1 Dec 2023 16:36:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=kAq+FlOBQeTEfoeBC926uoIFZPoW9EFEzZyzp+2x754=;
 b=C0gscrXN8epNqKDHcj8Uy0IaTgjRsdO0JbVTvBrRvWQNxuuGsYLdZQfP3h+RfpJZbbM4
 /oO4qHr0XX4JnzRhAPSKwZH8AbZBZeqjy8EFd9t9aM6raJxrcpKGVVIc4Nrd+YY08zwc
 HYjObC44graLMph3571hdbvy/FIz1Pe2bupXY5ordl3zWUscqopWIVRglzkVpZrNtd+H
 4aKxc9TkNdUcZn6MUyL7GKZwt5vVaOz8eSATUhCihg6dz9re4MSr8jnkP29/51BsSZ6n
 q2VPL7o9owEDAtT+Zzrrljx7puvtPJlsr0yQ9ILngTHp2/ps0gmB8FJQ66e1kMrzTqPh kQ== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uqk4qr0vw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 01 Dec 2023 16:36:03 +0000
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3B1GZgi9031282;
	Fri, 1 Dec 2023 16:36:03 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uqk4qr0pt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 01 Dec 2023 16:36:02 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3B1GO3h7006260;
	Fri, 1 Dec 2023 16:31:52 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3ukwfkntcp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 01 Dec 2023 16:31:52 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3B1GVnmf38994230
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 1 Dec 2023 16:31:49 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8368120043;
	Fri,  1 Dec 2023 16:31:49 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6B52C20040;
	Fri,  1 Dec 2023 16:31:48 +0000 (GMT)
Received: from [9.179.28.5] (unknown [9.179.28.5])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  1 Dec 2023 16:31:48 +0000 (GMT)
Message-ID: <ca1c7310-bc22-43e1-8fc9-f8bd046913dd@linux.ibm.com>
Date: Fri, 1 Dec 2023 17:31:48 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 4/7] net/smc: define a reserved CHID range for
 virtual ISM devices
Content-Language: en-US
To: Wen Gu <guwen@linux.alibaba.com>, wenjia@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com, agordeev@linux.ibm.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        kgraul@linux.ibm.com, jaka@linux.ibm.com
Cc: borntraeger@linux.ibm.com, svens@linux.ibm.com, alibuda@linux.alibaba.com,
        tonylu@linux.alibaba.com, raspl@linux.ibm.com, schnelle@linux.ibm.com,
        linux-s390@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1701343695-122657-1-git-send-email-guwen@linux.alibaba.com>
 <1701343695-122657-5-git-send-email-guwen@linux.alibaba.com>
From: Alexandra Winter <wintera@linux.ibm.com>
In-Reply-To: <1701343695-122657-5-git-send-email-guwen@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: fAew-WhCptEJ4lr6Y6ZYGya39UjrCJkN
X-Proofpoint-GUID: Al0qObizTPzgAKaA223V6BzoBn5rVw3a
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-01_15,2023-11-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 phishscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0
 mlxlogscore=842 mlxscore=0 suspectscore=0 malwarescore=0 clxscore=1015
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2312010113



On 30.11.23 12:28, Wen Gu wrote:
> According to virtual ISM support feature defined by SMCv2.1, CHIDs in
> the range 0xFF00 to 0xFFFF are reserved for use by virtual ISM devices.
> 
> And two helpers are introduced to distinguish virtual ISM devices from
> the existing platform firmware ISM devices.
> 
> Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
> ---

Reviewed-by: Alexandra Winter <wintera@linux.ibm.com>


