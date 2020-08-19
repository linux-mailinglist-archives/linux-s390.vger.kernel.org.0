Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9446D249A47
	for <lists+linux-s390@lfdr.de>; Wed, 19 Aug 2020 12:24:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727019AbgHSKYL (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Wed, 19 Aug 2020 06:24:11 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:58520 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726851AbgHSKYI (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 19 Aug 2020 06:24:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597832647;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yUyuzr512iWvlZpUh5hBu6/yG04pLgWz5naCF3J/3DQ=;
        b=WkavJWtVvl/azig6WuOTNv+q5cMLytZ2a/IrfFs3qurGQo24PPqostGJUM+lKMyfJ7UTTL
        3BNpSJQ7IVjrBCYJ3hdCKesLW9Vuk0UziFl1ADd+eB/UfyULPW213nQ9ucG6HB5WKJkLA+
        vZ1DNY8wxt1GoPZWfkBJ2owbvaambao=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-237-k4Io3TsLOsCu_DCjUcPscw-1; Wed, 19 Aug 2020 06:24:03 -0400
X-MC-Unique: k4Io3TsLOsCu_DCjUcPscw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3598F100CFC0;
        Wed, 19 Aug 2020 10:24:02 +0000 (UTC)
Received: from gondolin (ovpn-112-216.ams2.redhat.com [10.36.112.216])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8E5615C1D0;
        Wed, 19 Aug 2020 10:23:57 +0000 (UTC)
Date:   Wed, 19 Aug 2020 12:23:54 +0200
From:   Cornelia Huck <cohuck@redhat.com>
To:     Marc Hartmayer <mhartmay@linux.ibm.com>
Cc:     <kvm@vger.kernel.org>, Thomas Huth <thuth@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Andrew Jones <drjones@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390@vger.kernel.org
Subject: Re: [kvm-unit-tests PATCH 3/4] run_tests/mkstandalone: add arch_cmd
 hook
Message-ID: <20200819122354.3b9c9bbb.cohuck@redhat.com>
In-Reply-To: <20200818130424.20522-4-mhartmay@linux.ibm.com>
References: <20200818130424.20522-1-mhartmay@linux.ibm.com>
        <20200818130424.20522-4-mhartmay@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Tue, 18 Aug 2020 15:04:23 +0200
Marc Hartmayer <mhartmay@linux.ibm.com> wrote:

> This allows us, for example, to auto generate a new test case based on
> an existing test case.
> 
> Signed-off-by: Marc Hartmayer <mhartmay@linux.ibm.com>
> ---
>  scripts/common.bash | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>

