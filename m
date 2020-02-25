Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B756C16EBA3
	for <lists+linux-s390@lfdr.de>; Tue, 25 Feb 2020 17:43:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729680AbgBYQnH (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Tue, 25 Feb 2020 11:43:07 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:8424 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730315AbgBYQnG (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 25 Feb 2020 11:43:06 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01PGb7Yv057665
        for <linux-s390@vger.kernel.org>; Tue, 25 Feb 2020 11:43:04 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2yd4h2xtkr-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Tue, 25 Feb 2020 11:43:04 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Tue, 25 Feb 2020 16:43:02 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 25 Feb 2020 16:42:59 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 01PGgtXn37158976
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Feb 2020 16:42:55 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 93CEF52054;
        Tue, 25 Feb 2020 16:42:55 +0000 (GMT)
Received: from oc7455500831.ibm.com (unknown [9.145.53.31])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 0E0DB52050;
        Tue, 25 Feb 2020 16:42:55 +0000 (GMT)
Subject: Re: [PATCH v4 33/36] DOCUMENTATION: Protected virtual machine
 introduction and IPL
To:     Cornelia Huck <cohuck@redhat.com>
Cc:     Janosch Frank <frankja@linux.vnet.ibm.com>,
        KVM <kvm@vger.kernel.org>, David Hildenbrand <david@redhat.com>,
        Thomas Huth <thuth@redhat.com>,
        Ulrich Weigand <Ulrich.Weigand@de.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Michael Mueller <mimu@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>
References: <20200224114107.4646-1-borntraeger@de.ibm.com>
 <20200224114107.4646-34-borntraeger@de.ibm.com>
 <20200225172255.6ec8e7ac.cohuck@redhat.com>
From:   Christian Borntraeger <borntraeger@de.ibm.com>
Autocrypt: addr=borntraeger@de.ibm.com; prefer-encrypt=mutual; keydata=
 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
 nS4h0HDFPrrp1C2EMVYIQrMokWvlFZbCpsdYbBI=
Date:   Tue, 25 Feb 2020 17:42:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200225172255.6ec8e7ac.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 20022516-0020-0000-0000-000003AD7EE3
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20022516-0021-0000-0000-00002205962E
Message-Id: <f7d8e2f6-5ae2-939c-eaab-3019daefcc63@de.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-25_06:2020-02-21,2020-02-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 lowpriorityscore=0 mlxlogscore=999 impostorscore=0 adultscore=0
 bulkscore=0 suspectscore=0 phishscore=0 priorityscore=1501 clxscore=1015
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002250124
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org



On 25.02.20 17:22, Cornelia Huck wrote:
> On Mon, 24 Feb 2020 06:41:04 -0500
> Christian Borntraeger <borntraeger@de.ibm.com> wrote:
> 
>> From: Janosch Frank <frankja@linux.ibm.com>
>>
>> Add documentation about protected KVM guests and description of changes
>> that are necessary to move a KVM VM into Protected Virtualization mode.
>>
>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>> [borntraeger@de.ibm.com: fixing and conversion to rst]
>> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
>> ---
>>  Documentation/virt/kvm/index.rst        |   2 +
>>  Documentation/virt/kvm/s390-pv-boot.rst |  83 +++++++++++++++++
>>  Documentation/virt/kvm/s390-pv.rst      | 116 ++++++++++++++++++++++++
>>  MAINTAINERS                             |   1 +
>>  4 files changed, 202 insertions(+)
>>  create mode 100644 Documentation/virt/kvm/s390-pv-boot.rst
>>  create mode 100644 Documentation/virt/kvm/s390-pv.rst
>>
> (...)
>> diff --git a/Documentation/virt/kvm/s390-pv-boot.rst b/Documentation/virt/kvm/s390-pv-boot.rst
>> new file mode 100644
>> index 000000000000..b762df206ab7
>> --- /dev/null
>> +++ b/Documentation/virt/kvm/s390-pv-boot.rst
>> @@ -0,0 +1,83 @@
>> +.. SPDX-License-Identifier: GPL-2.0
>> +
>> +======================================
>> +s390 (IBM Z) Boot/IPL of Protected VMs
>> +======================================
>> +
>> +Summary
>> +-------
>> +The memory of Protected Virtual Machines (PVMs) is not accessible to
>> +I/O or the hypervisor. In those cases where the hypervisor needs to
>> +access the memory of a PVM, that memory must be made accessible.
>> +Memory made accessible to the hypervisor will be encrypted. See
>> +:doc:`s390-pv` for details."
>> +
>> +On IPL (boot) a small plaintext bootloader is started, which provides
>> +information about the encrypted components and necessary metadata to
>> +KVM to decrypt the protected virtual machine.
>> +
>> +Based on this data, KVM will make the protected virtual machine known
>> +to the Ultravisor(UV) and instruct it to secure the memory of the PVM,
> 
> s/Ultravisor(UV)/Ultravisor (UV)/

ack
> 
>> +decrypt the components and verify the data and address list hashes, to
>> +ensure integrity. Afterwards KVM can run the PVM via the SIE
>> +instruction which the UV will intercept and execute on KVM's behalf.
> (...)
>> +Subcodes 4 and 7, which specify operations that do not clear the guest
>> +memory, will result in specification exceptions. This is because the
>> +UV will clear all memory when a secure VM is removed, and therefore
>> +non-clearing IPL subcodes are not allowed."
> 
> stray '"'

ack
> 
> (...)
>> diff --git a/Documentation/virt/kvm/s390-pv.rst b/Documentation/virt/kvm/s390-pv.rst
>> new file mode 100644
>> index 000000000000..27fe03eaeaad
>> --- /dev/null
>> +++ b/Documentation/virt/kvm/s390-pv.rst
>> @@ -0,0 +1,116 @@
>> +.. SPDX-License-Identifier: GPL-2.0
>> +
>> +=========================================
>> +s390 (IBM Z) Ultravisor and Protected VMs
>> +=========================================
>> +
>> +Summary
>> +-------
>> +Protected virtual machines (PVM) are KVM VMs that do not allow KVM to
>> +access VM state like guest memory or guest registers. Instead, the
>> +PVMs are mostly managed by a new entity called Ultravisor (UV). The UV
>> +provides an API that can be used by PVMs and KVM to request management
>> +actions.
>> +
>> +Each guest starts in the non-protected mode and then may make a
> 
> s/in the/in/

ack.
> 
>> +request to transition into protected mode. On transition, KVM
>> +registers the guest and its VCPUs with the Ultravisor and prepares
>> +everything for running it.
> (...)
>> +
>> +Mask notification interceptions
>> +-------------------------------
>> +In order to be notified when a PVM enables a certain class of
>> +interrupt, KVM cannot intercept lctl(g) and lpsw(e) anymore. As a
> 
> "KVM cannot intercept (...) in order to notified..." might read a bit
> better.

ok.

>> +replacement, two new interception codes have been introduced: One
>> +indicating that the contents of CRs 0, 6, or 14 have been changed,
>> +indicating different interruption subclasses; and one indicating that
>> +PSW bit 13 has been changed, indicating that a machine check
>> +intervention was requested and those are now enabled.
>> +
>> +Instruction emulation
>> +---------------------
>> +With the format 4 state description for PVMs, the SIE instruction already
>> +interprets more instructions than it does with format 2. It is not able
>> +to interpret every instruction, but needs to hand some tasks to KVM;
>> +therefore, the SIE and the ultravisor safeguard emulation inputs and outputs.
>> +
>> +The control structures associated with SIE provide the Secure
>> +Instruction Data Area (SIDA), the Interception Parameters (IP) and the
>> +Secure Interception General Register Save Area.  Guest GRs and most of
>> +the instruction data, such as I/O data structures, are filtered.
>> +Instruction data is copied to and from the Secure Instruction Data
>> +Area (SIDA) when needed.  Guest GRs are put into / retrieved from the
> 
> I think you can use 'SIDA' directly the second time.

ack
> 
>> +Secure Interception General Register Save Area.
> 
> (...)
> 
> Otherwise,
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
> 

