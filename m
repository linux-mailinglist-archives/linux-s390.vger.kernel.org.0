Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 36E76120772
	for <lists+linux-s390@lfdr.de>; Mon, 16 Dec 2019 14:44:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727807AbfLPNno (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Mon, 16 Dec 2019 08:43:44 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:23314 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727609AbfLPNno (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 16 Dec 2019 08:43:44 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBGDcU1Q191464
        for <linux-s390@vger.kernel.org>; Mon, 16 Dec 2019 08:43:42 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2wwdxybnrc-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Mon, 16 Dec 2019 08:43:42 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <oberpar@linux.ibm.com>;
        Mon, 16 Dec 2019 13:43:40 -0000
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 16 Dec 2019 13:43:36 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xBGDhZlk46268760
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 Dec 2019 13:43:35 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 02997AE053;
        Mon, 16 Dec 2019 13:43:35 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9E2B6AE056;
        Mon, 16 Dec 2019 13:43:34 +0000 (GMT)
Received: from [9.152.212.29] (unknown [9.152.212.29])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 16 Dec 2019 13:43:34 +0000 (GMT)
Subject: Re: [RFC QEMU PATCH] pc-bios/s390-ccw: Add zipl-like "BOOT_IMAGE=x"
 to the kernel parameters
To:     Christian Borntraeger <borntraeger@de.ibm.com>,
        Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
        Stefan Haberland <sth@linux.ibm.com>
Cc:     qemu-s390x@nongnu.org, Cornelia Huck <cohuck@redhat.com>,
        psundara@redhat.com,
        =?UTF-8?Q?Jan_H=c3=b6ppner?= <hoeppner@linux.ibm.com>,
        linux-s390@vger.kernel.org
References: <20191216112432.13412-1-thuth@redhat.com>
 <ffea8f68-714b-798e-3563-12f9bf0668fa@de.ibm.com>
From:   Peter Oberparleiter <oberpar@linux.ibm.com>
Date:   Mon, 16 Dec 2019 14:43:33 +0100
MIME-Version: 1.0
In-Reply-To: <ffea8f68-714b-798e-3563-12f9bf0668fa@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19121613-0016-0000-0000-000002D564B1
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19121613-0017-0000-0000-0000333798B8
Message-Id: <ea23540a-34bc-bdc3-07f2-8c7b21fe16c7@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-16_05:2019-12-16,2019-12-16 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011 impostorscore=0
 suspectscore=1 lowpriorityscore=0 mlxlogscore=999 mlxscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912160122
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 16.12.2019 12:29, Christian Borntraeger wrote:
> 
> 
> On 16.12.19 12:24, Thomas Huth wrote:
>>  Note: I've marked the patch as RFC since I'm not quite sure whether
>>  this is really the right way to address this issue: It's unfortunate
>>  that we have to mess with different location in ZIPL which might also
>>  change again in the future.

Having QEMU or any other tooling rely on undocumented on-disk format
specifics of zipl is definitely wrong and prone to break with the next
change. This is _not_ an ABI.

>>  As suggested by Christian on IRC last week,
>>  maybe it would make more sense to change ZIPL to add this parameter
>>  already when zipl is installed (i.e. by the Linux userspace "zipl" pro-
>>  gram), instead of adding it during boot time? Also, the BOOT_IMAGE para-
>>  meter on s390x is quite different from the BOOT_IMAGE paramter that is
>>  used on x86 - while s390x only uses one single number here, the x86
>>  variant (added by grub2, I guess) uses the boot device + full filename
>>  of the kernel on the boot partition. Should we maybe make the s390x
>>  variant more conform to x86? If so, I think this really has to be fixed
>>  in zipl userspace tool, and not in the s390-ccw bios (and zipl stage3
>>  bootloader).
> 
> Yes, I actually think we should revisit the whole BOOT_IMAGE scheme on s390.
> Maybe we should use the kernel name, or the name of the boot menu entry.
> And maybe we should not use 0 (when the default is running) but instead
> really use to what 0 points to.

BOOT_IMAGE on s390 currently only exists for DASD, so any tooling that
relies on it today would be broken for SCSI boot. The equivalent
information for SCSI would be the boot program selector at
/sys/firmware/ipl/bootprog. There is currently no other way to get this
information when booting from DASD.

Also note that the format of BOOT_IMAGE is dependent on the boot loader
that created it. The use of the menu number (and 0 for default) has the
advantage that this number can be used, e.g. to select the same number
for the next boot using the LOADPARM. Changing BOOT_IMAGE to show the
kernel name would take away that use case.

At this time I would suggest to start by identifying any current users
of BOOT_IMAGE and to understand what their actual requirement is. Once
that information is available, we can think about how this requirement
could best be implemented. Looking at the dracut link it seems like
their requirement cannot be met at all with the information currently
provided on s390 via the BOOT_IMAGE parameter.

-- 
Peter Oberparleiter
Linux on Z Development - IBM Germany

