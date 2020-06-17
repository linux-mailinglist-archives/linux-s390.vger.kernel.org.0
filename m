Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 969D11FC85C
	for <lists+linux-s390@lfdr.de>; Wed, 17 Jun 2020 10:13:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725941AbgFQINp (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Wed, 17 Jun 2020 04:13:45 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:52224 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725773AbgFQINo (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 17 Jun 2020 04:13:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592381623;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+1alsiIWHZc0JfJZ98mEf3xji1GMsCQin/jc8f2S8mU=;
        b=SQlfHFdP1Zngekc+pGZ3rKQeJaKEexPK6I+Ny6UNYsa6AkidvGXbWM0+ntajvbPhACLF4S
        /5IOzPu90Jj2wR87kTF1LXh867OsA6TUlE8kYY1Yi0iQhQ87AhVhp2iYOvC+v+zybwc/s8
        3WcuzFr2iT8bNMvE4N7XV4qryMe5f1M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-237-XirK8OphPsmh1sD5vDe57w-1; Wed, 17 Jun 2020 04:13:39 -0400
X-MC-Unique: XirK8OphPsmh1sD5vDe57w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 86AA01009618;
        Wed, 17 Jun 2020 08:13:38 +0000 (UTC)
Received: from gondolin (ovpn-112-222.ams2.redhat.com [10.36.112.222])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 83BA519724;
        Wed, 17 Jun 2020 08:13:34 +0000 (UTC)
Date:   Wed, 17 Jun 2020 10:13:32 +0200
From:   Cornelia Huck <cohuck@redhat.com>
To:     Pierre Morel <pmorel@linux.ibm.com>
Cc:     kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        frankja@linux.ibm.com, david@redhat.com, thuth@redhat.com
Subject: Re: [kvm-unit-tests PATCH v9 03/12] s390x: saving regs for
 interrupts
Message-ID: <20200617101332.7baf9bc4.cohuck@redhat.com>
In-Reply-To: <1592213521-19390-4-git-send-email-pmorel@linux.ibm.com>
References: <1592213521-19390-1-git-send-email-pmorel@linux.ibm.com>
        <1592213521-19390-4-git-send-email-pmorel@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Mon, 15 Jun 2020 11:31:52 +0200
Pierre Morel <pmorel@linux.ibm.com> wrote:

> If we use multiple source of interrupts, for example, using SCLP
> console to print information while using I/O interrupts, we need
> to have a re-entrant register saving interruption handling.
> 
> Instead of saving at a static memory address, let's save the base
> registers, the floating point registers and the floating point
> control register on the stack in case of I/O interrupts
> 
> Note that we keep the static register saving to recover from the
> RESET tests.
> 
> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> Acked-by: Janosch Frank <frankja@linux.ibm.com>
> Acked-by: Thomas Huth <thuth@redhat.com>
> ---
>  s390x/cstart64.S | 41 +++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 39 insertions(+), 2 deletions(-)

Acked-by: Cornelia Huck <cohuck@redhat.com>

