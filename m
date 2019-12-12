Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A91BA11D52D
	for <lists+linux-s390@lfdr.de>; Thu, 12 Dec 2019 19:20:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730357AbfLLSUP (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Thu, 12 Dec 2019 13:20:15 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:13318 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730343AbfLLSUP (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 12 Dec 2019 13:20:15 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBCI9fbB037571
        for <linux-s390@vger.kernel.org>; Thu, 12 Dec 2019 13:20:13 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2wuswr97d1-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 12 Dec 2019 13:20:13 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <pmorel@linux.ibm.com>;
        Thu, 12 Dec 2019 18:20:11 -0000
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 12 Dec 2019 18:20:08 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xBCIK7an39322082
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Dec 2019 18:20:08 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D73D2A405F;
        Thu, 12 Dec 2019 18:20:07 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AB5CCA406A;
        Thu, 12 Dec 2019 18:20:07 +0000 (GMT)
Received: from oc3016276355.ibm.com (unknown [9.152.222.89])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 12 Dec 2019 18:20:07 +0000 (GMT)
Subject: Re: [kvm-unit-tests PATCH v4 8/9] s390x: css: ssch/tsch with sense
 and interrupt
From:   Pierre Morel <pmorel@linux.ibm.com>
To:     Cornelia Huck <cohuck@redhat.com>
Cc:     kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        frankja@linux.ibm.com, david@redhat.com, thuth@redhat.com
References: <1576079170-7244-1-git-send-email-pmorel@linux.ibm.com>
 <1576079170-7244-9-git-send-email-pmorel@linux.ibm.com>
 <20191212132634.3a16a389.cohuck@redhat.com>
 <1ea58644-9f24-f547-92d5-a99dcb041502@linux.ibm.com>
Date:   Thu, 12 Dec 2019 19:20:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <1ea58644-9f24-f547-92d5-a99dcb041502@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19121218-0012-0000-0000-000003743795
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19121218-0013-0000-0000-000021B014CF
Message-Id: <96034dbc-489a-7f76-0402-d5c0c42d20b3@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-12_06:2019-12-12,2019-12-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=789 clxscore=1015 priorityscore=1501 adultscore=0
 impostorscore=0 phishscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0
 spamscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912120140
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org



On 2019-12-12 15:10, Pierre Morel wrote:
> 
> 
> On 2019-12-12 13:26, Cornelia Huck wrote:
>> On Wed, 11 Dec 2019 16:46:09 +0100
>> Pierre Morel <pmorel@linux.ibm.com> wrote:
>>

...


> 
>>
>> Also, doesn't the interrupt handler check for the intparm already?
> 
> Yes, if the interrupt fires.
> 
>>
>>> +
>>> +    senseid.cu_type = buffer[2] | (buffer[1] << 8);
>>
>> This still looks odd; why not have the ccw fill out the senseid
>> structure directly?
> 
> Oh sorry, you already said and I forgot to modify this.
> thanks

hum, sorry, I forgot, the sense structure is not padded so I need this.

Regards,
Pierre

-- 
Pierre Morel
IBM Lab Boeblingen

