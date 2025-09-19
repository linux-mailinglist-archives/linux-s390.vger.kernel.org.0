Return-Path: <linux-s390+bounces-13483-lists+linux-s390=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C5B5B88112
	for <lists+linux-s390@lfdr.de>; Fri, 19 Sep 2025 08:54:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE5344E2D75
	for <lists+linux-s390@lfdr.de>; Fri, 19 Sep 2025 06:53:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A83D625A326;
	Fri, 19 Sep 2025 06:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="JfY3wa8n"
X-Original-To: linux-s390@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19C9B253958
	for <linux-s390@vger.kernel.org>; Fri, 19 Sep 2025 06:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758264809; cv=none; b=H3KM0Js/sfn/Rjnbho9gJPPLu8mnBbQDj2RL1PxH+laBYf5rFnPZnp99CZx+F7UO53HLqpniSnKhbwGgQYPyo+FOdwp3cE7oAcj9HLkmbSz+T+3qPGG/i40HkSJWfw/0oQmRV/yCmCFgmd4RbG38FhGmMvl2rInlYLfRmfTOnsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758264809; c=relaxed/simple;
	bh=6mu5r/20fn8IJXO2AldBdlWVvRnI63AzYbfukrUgu9E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZoIMqOWw3YaisMCqaP5KpesZVwGw4cRd7ZoIOo/SG2+f3CrJxcXz729q7HNWb4T7ibwBEaVDtBu5SCulXhmmOxN1bL0YNTHxPV4ZQ2ek9yLHosNydaj2x9J7IsrHg4tgNroMBFGVJwOK5bHs882M6pTs2K5ZhfEgt6zEZxN4l7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=JfY3wa8n; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58IMEfl8011938;
	Fri, 19 Sep 2025 06:53:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=9+2B8H
	BlspqcBDCE1e33XLQoChBnf6tm8BUUbd6SXXg=; b=JfY3wa8nbutWOU27yuTKRk
	4pyXbCjrTf1cuI413lCi8RU4rQRbPw2LAX6IH/byICCA4+ujzSy5fPmo8DMSwZqn
	KpIiCu7qO54R3qg/iz4wYZ4tdBLzbo8ukwRzBECl32qhjDdbaW5Qt6uVWsrlxQtE
	1dmyBSUVATU4US+TDGBI+KAATHtnrXFgAa+o1t3LEV18mK6P/VayeAQDCVSgw7Lv
	2MqzaIwQQUzEtRvlsBz9QXabgJjwGoDMmnJC6q2ovoi6LIkpw7AfN0TEO3HbSGAP
	QgCg2TQWr1fdBisc68sAfiRhA1t047moORerTpy2+f6qmcxvZC4tU4ybmtYSt43Q
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 497g4jeyw4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Sep 2025 06:53:17 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 58J6kQP4016183;
	Fri, 19 Sep 2025 06:53:16 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 497g4jeyw1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Sep 2025 06:53:16 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58J4mJ56005981;
	Fri, 19 Sep 2025 06:53:15 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 495jxujuv6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Sep 2025 06:53:15 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58J6rB8S19989122
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Sep 2025 06:53:11 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B201D20043;
	Fri, 19 Sep 2025 06:53:11 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7419620040;
	Fri, 19 Sep 2025 06:53:11 +0000 (GMT)
Received: from [9.111.165.4] (unknown [9.111.165.4])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 19 Sep 2025 06:53:11 +0000 (GMT)
Message-ID: <ed4eba43-9d13-4875-a264-233879733bfb@linux.ibm.com>
Date: Fri, 19 Sep 2025 08:53:11 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/7] dm-integrity: asynchronous hash support
To: Mikulas Patocka <mpatocka@redhat.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Biggers <ebiggers@kernel.org>, dengler@linux.ibm.com,
        linux-s390@vger.kernel.org, dm-devel@lists.linux.dev, agk@redhat.com,
        snitzer@kernel.org, Milan Broz <gmazyland@gmail.com>,
        freude@linux.ibm.com
References: <20250908131642.385445532@debian4.vm>
 <3a6b6f8f-5205-459c-810a-2425aae92fc8@linux.ibm.com>
 <e1e420d5-dc00-14d0-fdef-635d6ef70811@redhat.com>
 <bb68f9d6-8180-4291-9e6b-33bbdcef780f@linux.ibm.com>
 <8cb59ed5-1c9a-49de-beee-01eda52ad618@linux.ibm.com>
 <1af710ec-0f23-2522-d715-e683b9e557d8@redhat.com>
 <f799d7ab97470f2529b8dcb5566fd673@linux.ibm.com>
Content-Language: en-US, de-DE
From: Ingo Franzki <ifranzki@linux.ibm.com>
In-Reply-To: <f799d7ab97470f2529b8dcb5566fd673@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Qf5mvtbv c=1 sm=1 tr=0 ts=68ccfddd cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=p0WdMEafAAAA:8 a=VnNF1IyMAAAA:8
 a=O-Iw-kRxmlZWIl0LCTAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: OU8-asROO__vzBoI1aD_ZwN-ZIF3k9js
X-Proofpoint-GUID: TXVOcf43IzvITQu72NmMkL7l_uXoOXGq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwNCBTYWx0ZWRfX1gRzfphqFSbT
 DVEmRft/CtF/Wlmnt7gRogtUPrRv5dOAoJo1vKVKGlCNfbF+vrqO3diOcBxW6xMuqpl51Ob6Zoe
 B0t97DD6vtXkoiLKE7AdLsUaWCvFsboZCiUfnkePQo4rpTi6b18M1/OBrtYvwg0LINNINQLxc8N
 j73qNiU7TBfVDh4Qzvq9QbFezTQIzJzP+cI46bBg2IamMbhCh5j6X4NumhqfV79sC6gdzLt9M4a
 f9kOOYp+RnirG+TyGDfbR3cOd1L4NPGBR81Ns5TrQrUZO9r+3tmUs/l95Jvnq28/4ImliOwGIpf
 8bac5QKhCSXOsVCrJjB6iWifSkn5FZhxDL4CzELWtUGJpQj6D+esec0cezQxq0GqbrY+HfXlmHC
 7+RIZ0KZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-18_03,2025-09-19_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 phishscore=0 suspectscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509160204

On 18.09.2025 17:00, Harald Freudenberger wrote:
> On 2025-09-11 17:58, Mikulas Patocka wrote:
>> On Thu, 11 Sep 2025, Ingo Franzki wrote:
>>
>>> >> So, it looks like a dm-crypt bug.
>>> >>
>>> >> Please, revert my patches and run the same test on a clean 6.17.0-rc5 just
>>> >> to verify that the patches do not introduce the bug.
>>> >
>>> > With your patches reverted the combined mode fails the same way as with your patches.
>>> > So they did not introduce the bug.
>>>
>>> Mikulas, do you have any idea what could be causing this errors?
>>> Is it that dm-crypt is not properly dealing with async-only HMAC ciphers?
>>> Async-only encryption ciphers seem to work fine in dm-crypt, since LUKS with PAES (but no integrity) works fine, and PAES is an async-onky cipher.
>>> LUKS with sync-HMAC ciphers (e.g. clear key HMAC) also works fine, even in combination with PAES.
>>
>> Yes, I think that it's a problem with async HMAC. The bug is probably
>> either in dm-crypt or in the crypto library.
>>
>> Do you have some other (non-dm-crypt-related) workload that uses the
>> async authentication, so that we can determine whether the bug is in
>> dm-crypt or crypto?
>>
>> Otherwise, would it be possible to give us a virtual machine on the
>> mainframe to debug this issue?
>>
>> Mikulas
> 
> So here is now an out-of-tree kernel module build which offers a pseudo phmac-sha256
> for testing and debugging purpose. In the end this is just a asynch (ahash) wrapper
> around the hmac-sha256 shash crypto subsystem implementation. It should compile and
> be usable on all platforms (s390, x64, arm, ...).
> 
> I ran dm-integrity tests with this and all worked fine. Ingo ran dm-crypt tests
> where he combined aes-cbc encryption with phmac-sha256 integrity and saw hangs
> on cryptsetup open. He also reported that these issues are different to what he
> saw with the 'real' phmac in combination with aes encryption. A short glimpse gives
> me the impression that there is a job blocking the system's workqueue. However, I
> could not find any indication that the pseudo phmac is not working properly.

Here is what I did (after insmod'ing the pseudo phmac cipher).
I did this on a s390x system, but it should behave the same on x86.

# cryptsetup luksFormat --type luks2 --integrity phmac-sha256 --integrity-key-size 256  /dev/loop0
# cryptsetup luksOpen /dev/loop0 int-loop

Note: To use the above cryptsetup commands with phmac you might need the code from this cryptsetup PR, otherwise it won't accept phmac as integrity algorithm: https://gitlab.com/cryptsetup/cryptsetup/-/merge_requests/693

The luksOpen step hangs forever and the following messages are shown in syslog after a while:

Sep 19 02:43:29 fedora systemd-udevd[500]: dm-1: Worker [2720] processing SEQNUM=1272 is taking a long time
Sep 19 02:45:29 fedora systemd-udevd[500]: dm-1: Worker [2720] processing SEQNUM=1272 killed

Still the luksOpen keeps hanging, and a lot of kworkers are hanging around as well: 

# ps -ef
...
root        2679    1987  2 02:42 pts/0    00:00:04 cryptsetup luksOpen /dev/loop0 int-loop
root        2712       2  0 02:42 ?        00:00:00 [kworker/R-kdmflush/251:0]
root        2713       2  0 02:42 ?        00:00:00 [kworker/R-dm-integrity-metadata]
root        2714       2  0 02:42 ?        00:00:00 [kworker/R-dm-integrity-wait]
root        2715       2  0 02:42 ?        00:00:00 [kworker/R-dm-integrity-offload]
root        2716       2  0 02:42 ?        00:00:00 [kworker/R-dm-integrity-commit]
root        2717       2  0 02:42 ?        00:00:00 [kworker/R-dm-integrity-writer]
root        2718     500  0 02:42 ?        00:00:00 (udev-worker)
root        2719     500  0 02:42 ?        00:00:00 (udev-worker)
root        2720     500  0 02:42 ?        00:00:00 [(udev-worker)]
root        2726       2  0 02:42 ?        00:00:00 [kworker/R-kdmflush/251:1]
root        2727       2  0 02:42 ?        00:00:00 [kworker/R-kcryptd_io-251:1-1]
root        2728       2  0 02:42 ?        00:00:00 [kworker/R-kcryptd-251:1-1]
root        2729       2  0 02:42 ?        00:00:00 [dmcrypt_write/251:1]
...

# dmsetup table
int-loop: 0 351128 crypt capi:authenc(phmac(sha256),xts(aes))-plain64 :96:logon:cryptsetup:239c87ad-8c23-4cdb-943f-947737e9cf5c-d0 0 251:0 0 2 integrity:32:aead integrity_key_size:32
int-loop_dif: 0 351128 integrity 7:0 32768 32 J 6 interleave_sectors:32768 buffer_sectors:128 journal_sectors:3168 journal_watermark:50 commit_time:10000 fix_padding

# lsblk
NAME           MAJ:MIN RM   SIZE RO TYPE  MOUNTPOINTS
loop0            7:0    0   200M  0 loop
└─int-loop_dif 251:0    0 171.4M  0 crypt


> 
> For instructions on how to build and use the module see the README in the tgz archive.
> 
> Thanks to all
> Harald Freudenberger
> 
> 


-- 
Ingo Franzki
eMail: ifranzki@linux.ibm.com  
Tel: ++49 (0)7031-16-4648
Linux on IBM Z Development, Schoenaicher Str. 220, 71032 Boeblingen, Germany

IBM Deutschland Research & Development GmbH
Vorsitzender des Aufsichtsrats: Gregor Pillen
Geschäftsführung: David Faller
Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294
IBM DATA Privacy Statement: https://www.ibm.com/privacy/us/en/

