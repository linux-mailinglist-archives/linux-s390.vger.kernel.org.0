Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36F8E203CA8
	for <lists+linux-s390@lfdr.de>; Mon, 22 Jun 2020 18:35:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729458AbgFVQfc (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Mon, 22 Jun 2020 12:35:32 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:29503 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729260AbgFVQfc (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 22 Jun 2020 12:35:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592843730;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oDGPrT+UHAYSewY+/BQy3rzkizwDqx2Y3vMJsWA2ii4=;
        b=dRjcg+8hJDmmB38xea9myzlVM12T1J2Xy6HCkkCB2wux9nJr6WiG44oXeqnWgiREDCTgYZ
        cZQeZL7jtTNJU/ot5El5BFZVx7e2yJbR+GUvJH2LnHIZNR0lHfa/o1QgOg9inkPdFx+LAs
        oShluH58q1TyfQp1vAoHEu8Cxnmu0WY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-180-csvSNXo3PmKwlGHs4ctNHQ-1; Mon, 22 Jun 2020 12:35:26 -0400
X-MC-Unique: csvSNXo3PmKwlGHs4ctNHQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 43F5310A57C4;
        Mon, 22 Jun 2020 16:35:19 +0000 (UTC)
Received: from gondolin (ovpn-113-56.ams2.redhat.com [10.36.113.56])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0D6A610013D7;
        Mon, 22 Jun 2020 16:35:16 +0000 (UTC)
Date:   Mon, 22 Jun 2020 18:35:12 +0200
From:   Cornelia Huck <cohuck@redhat.com>
To:     Collin Walling <walling@linux.ibm.com>
Cc:     kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        pbonzini@redhat.com, borntraeger@de.ibm.com, frankja@linux.ibm.com,
        david@redhat.com, imbrenda@linux.ibm.com,
        heiko.carstens@de.ibm.com, gor@linux.ibm.com, thuth@redhat.com
Subject: Re: [PATCH v9 2/2] s390/kvm: diagnose 0x318 sync and reset
Message-ID: <20200622183512.3547d21b.cohuck@redhat.com>
In-Reply-To: <cda0b27f-ec26-e596-9814-c4ce81915bcb@linux.ibm.com>
References: <20200622154636.5499-1-walling@linux.ibm.com>
        <20200622154636.5499-3-walling@linux.ibm.com>
        <20200622180459.4cf7cbf4.cohuck@redhat.com>
        <93bd30de-2cd0-a044-4e9b-05b1eda9acb3@linux.ibm.com>
        <cda0b27f-ec26-e596-9814-c4ce81915bcb@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Mon, 22 Jun 2020 12:23:45 -0400
Collin Walling <walling@linux.ibm.com> wrote:

> Mind if I get some early feedback for the first run? How does this sound:
> 
> 8.24 KVM_CAP_S390_DIAG318
> -------------------------
> 
> :Architecture: s390
> 
> This capability allows for information regarding the control program
> that may be observed via system/firmware service events. The
> availability of this capability indicates that KVM handling of the
> register synchronization, reset, and VSIE shadowing of the DIAGNOSE
> 0x318 related information is present.
> 
> The information associated with the instruction is an 8-byte value
> consisting of a one-byte Control Program Name Code (CPNC), and a 7-byte
> Control Program Version Code (CPVC). The CPNC determines what
> environment the control program is running in (e.g. Linux, z/VM...), and
> the CPVC is used for extraneous information specific to OS (e.g. Linux
> version, Linux distribution...)
> 
> The CPNC must be stored in the SIE block for the CPU that executes the
> diag instruction, which is communicated from userspace to KVM via
> register synchronization using the KVM_SYNC_DIAG318 flag. Both codes are
> stored together in the kvm_vcpu_arch struct.

Hm... what about replacing that last paragraph with

"If this capability is available, the CPNC and CPVC are available for
synchronization between KVM and userspace via the sync regs mechanism
(KVM_SYNC_DIAG318)."

?

