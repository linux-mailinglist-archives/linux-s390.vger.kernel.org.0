Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8EE9456CB5
	for <lists+linux-s390@lfdr.de>; Fri, 19 Nov 2021 10:47:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbhKSJr6 (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Fri, 19 Nov 2021 04:47:58 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:50702 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230121AbhKSJr5 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 19 Nov 2021 04:47:57 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AJ8HLih004708;
        Fri, 19 Nov 2021 09:44:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : from : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=NGoj0N+5MQHpujuMsn7CYheTHXNYxglCqzJFOJPsCXw=;
 b=OYKScG/65e19RTuc1+kDEVK/7FIMmeaISrwvfuh9uTxoCJWUd9OlHROEc0fyf+zrBBNH
 G+hFZEEw90l6VcNPi4vDMYD/MMe4M8ffIfXmi0wjUDjSEYIzfV4j1XEgw2hDBwNEcdiK
 I+NrriWccNipevBBk91MD4YITJ3XgR5dloq2NBU7iq/h7WCiQm7VPQ+MDbplvZ+D1suo
 8GstMcaFPpYYIYSoiaxN7JP51reOjw7FpKBEntOQWbgZBXpNYl8ndj/w0eFU/HX0tFyo
 8zTXSZEBruAs3eGgoyMW1VsvYIimDY37TcVFRpfCWvHkMf4WYYrdSu/zxPHsj01jQk1m Tw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ce89khnrj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 Nov 2021 09:44:53 +0000
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1AJ9ZLjU030167;
        Fri, 19 Nov 2021 09:44:53 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ce89khnqr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 Nov 2021 09:44:52 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1AJ9fWdw013742;
        Fri, 19 Nov 2021 09:44:50 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma06ams.nl.ibm.com with ESMTP id 3ca4mkq2db-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 Nov 2021 09:44:50 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1AJ9ijR535717504
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Nov 2021 09:44:45 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5E904A405C;
        Fri, 19 Nov 2021 09:44:45 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CE948A4064;
        Fri, 19 Nov 2021 09:44:44 +0000 (GMT)
Received: from [9.171.67.41] (unknown [9.171.67.41])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 19 Nov 2021 09:44:44 +0000 (GMT)
Message-ID: <4ee51adb-090f-071f-6f0e-ab739fe98498@de.ibm.com>
Date:   Fri, 19 Nov 2021 10:44:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH] s390/test_unwind: use raw opcode instead of invalid
 instruction
Content-Language: en-US
From:   Christian Borntraeger <borntraeger@de.ibm.com>
To:     Nick Desaulniers <ndesaulniers@google.com>,
        Ilie Halip <ilie.halip@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Mete Durlu <meted@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        linux-s390@vger.kernel.org, llvm@lists.linux.dev,
        Ulrich Weigand <Ulrich.Weigand@de.ibm.com>
References: <20211117174822.3632412-1-ilie.halip@gmail.com>
 <CAKwvOd=9tsHHhPBOx2ORZoJP09VsX5dRZn58qj3MzCc2vmVosg@mail.gmail.com>
 <d9ec2704-f41c-eafa-1945-ce845d65be8a@de.ibm.com>
In-Reply-To: <d9ec2704-f41c-eafa-1945-ce845d65be8a@de.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: AgTfzTvw5JUUWVMjkdRGkA2mfk3xu8w7
X-Proofpoint-ORIG-GUID: ayZ2O5L9k6jI-ipl9PKRpqb0dUGDEure
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-19_08,2021-11-17_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 impostorscore=0 adultscore=0 clxscore=1015 priorityscore=1501
 spamscore=0 malwarescore=0 mlxlogscore=999 phishscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111190052
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org



Am 19.11.21 um 10:39 schrieb Christian Borntraeger:
> 
> 
> Am 19.11.21 um 02:10 schrieb Nick Desaulniers:
>> On Wed, Nov 17, 2021 at 9:48 AM Ilie Halip <ilie.halip@gmail.com> wrote:
>>>
>>> Building with clang & LLVM_IAS=1 leads to an error:
>>>      arch/s390/lib/test_unwind.c:179:4: error: invalid register pair
>>>                          "       mvcl    %%r1,%%r1\n"
>>>                          ^
>>>
>>> The test creates an invalid instruction that would trap at runtime, but the
>>> LLVM inline assembler tries to validate it at compile time too.
>>>
>>> Use the raw instruction opcode instead.
>>>
>>> Link: https://github.com/ClangBuiltLinux/linux/issues/1421
>>> Reported-by: Nick Desaulniers <ndesaulniers@google.com>
>>> Signed-off-by: Ilie Halip <ilie.halip@gmail.com>
>>
>> Ilie, thanks for the patch!
>>
>> So if I understand
>> https://sourceware.org/binutils/docs/as/s390-Directives.html#s390-Directives
>> https://sourceware.org/binutils/docs/as/s390-Formats.html
>> that `e,` prefix is for 16B opcodes?
> 
> e is an instruction format as specified by the architecture.
> See http://publibfp.dhe.ibm.com/epubs/pdf/a227832c.pdf

(page 5-3 for the instruction formats and page 7-289 for MVCL)
